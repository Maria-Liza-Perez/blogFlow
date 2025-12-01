<?php
defined('PREVENT_DIRECT_ACCESS') OR exit('No direct script access allowed');

use Symfony\Component\Mailer\Mailer;
use Symfony\Component\Mailer\Transport;
use Symfony\Component\Mime\Email as SymfonyEmail;

if (!class_exists('Email')) {

class Email {
    private $mailer;
    private $sender;
    public $sender_name = '';
    private $recipients = array();
    private $reply_to = '';
    private $subject;
    private $attach_files = array();
    private $emailContent = '';
    private $emailType = 'plain';
    private $last_error = '';

    private $_lava;

    public function __construct()
    {
        if (!class_exists(Mailer::class)) {
            throw new \RuntimeException('Symfony Mailer is not installed. Run composer install.');
        }

        $dsn = getenv('MAILER_DSN');
        if (!$dsn) {
            $host   = getenv('SMTP_HOST')   ?: 'smtp.gmail.com';
            $port   = getenv('SMTP_PORT')   ?: '587';
            $user   = getenv('SMTP_USER')   ?: '';
            $pass   = getenv('SMTP_PASS')   ?: '';
            $secure = getenv('SMTP_SECURE') ?: 'tls';

            $dsn = sprintf(
                'smtp://%s:%s@%s:%s?encryption=%s',
                rawurlencode($user),
                rawurlencode($pass),
                $host,
                $port,
                $secure
            );
        }

        $transport = Transport::fromDsn($dsn);
        $this->mailer = new Mailer($transport);

        $this->_lava = function_exists('lava_instance') ? lava_instance() : null;
    }

    private function valid_email($email)
    {
        $email = filter_var($email, FILTER_SANITIZE_EMAIL);
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return true;
        }
        throw new \InvalidArgumentException('Invalid email address');
    }

    private function filter_string($string)
    {
        return filter_var($string, FILTER_UNSAFE_RAW, FILTER_FLAG_STRIP_HIGH);
    }

    public function sender($sender_email, $display_name = '')
    {
        if (!empty($sender_email) && $this->valid_email($sender_email)) {
            $this->sender = $sender_email;
            if (!is_null($display_name)) {
                $this->sender_name = $this->filter_string($display_name);
            }
            return $this->sender;
        }
    }

    public function recipient($recipient)
    {
        try {
            if (!empty($recipient) && $this->valid_email($recipient)) {
                if (!in_array($recipient, $this->recipients)) {
                    $this->recipients[] = $recipient;
                }
                return true;
            }
        } catch (\Throwable $e) {
            $this->last_error = 'Invalid recipient email: ' . $e->getMessage();
            return false;
        }
        return false;
    }

    public function reply_to($reply_to)
    {
        if ($this->valid_email($reply_to)) {
            $this->reply_to = $reply_to;
            return $this->reply_to;
        }
    }

    public function subject($subject)
    {
        if (!empty($subject)) {
            $this->subject = $this->filter_string($subject);
            return $this->subject;
        }
        throw new \InvalidArgumentException("Email subject is empty");
    }

    public function email_content($emailContent, $type = 'plain')
    {
        if ($type !== 'html') {
            $emailContent = wordwrap($emailContent, 70, "\n");
        }
        $this->emailContent = $emailContent;
        $this->emailType = $type;
    }

    public function attachment($attach_file)
    {
        if (!empty($attach_file)) {
            if (!in_array($attach_file, $this->attach_files)) {
                $this->attach_files[] = $attach_file;
            }
        } else {
            throw new \InvalidArgumentException("No file attachment was specified");
        }
    }

    private function log_email($to, $status, $errorMessage = null)
    {
        if (!$this->_lava || !isset($this->_lava->db)) {
            return;
        }

        $preview = strip_tags((string)$this->emailContent);
        if (strlen($preview) > 255) {
            $preview = substr($preview, 0, 252) . '...';
        }

        try {
            $this->_lava->db->table('email_logs')->insert([
                'to_email'      => $to,
                'subject'       => (string)$this->subject,
                'body_preview'  => $preview,
                'status'        => $status,
                'error_message' => $errorMessage,
                'sent_at'       => date('Y-m-d H:i:s'),
            ]);
        } catch (\Throwable $e) {
            error_log('Failed to insert email_logs: ' . $e->getMessage());
        }
    }

    public function send()
    {
        $this->last_error = '';

        if (!is_array($this->recipients) || count($this->recipients) < 1) {
            $this->last_error = 'No recipient email address specified';
            return false;
        }

        if (empty($this->subject)) {
            $this->last_error = 'Email subject is empty';
            return false;
        }

        $email = (new SymfonyEmail());

        try {
            if (!empty($this->sender)) {
                $email->from($this->sender_name ? "{$this->sender_name} <{$this->sender}>" : $this->sender);
            } else {
                $from = getenv('SMTP_USER') ?: null;
                if (!$from) {
                    $this->last_error = 'No sender email address configured';
                    return false;
                }
                $email->from($from);
            }

            foreach ($this->recipients as $r) {
                $email->addTo($r);
            }

            if (!empty($this->reply_to)) {
                $email->replyTo($this->reply_to);
            }

            $email->subject($this->subject);

            if ($this->emailType === 'html') {
                $email->html($this->emailContent);
                $email->text(strip_tags($this->emailContent));
            } else {
                $email->text($this->emailContent);
            }

            foreach ($this->attach_files as $file) {
                if (file_exists($file)) {
                    $email->attachFromPath($file);
                }
            }

            $this->mailer->send($email);

            $this->log_email($this->recipients[0], 'success', null);
            return true;
        } catch (\Throwable $e) {
            $this->last_error = $e->getMessage();
            $this->log_email($this->recipients[0] ?? null, 'failure', $e->getMessage());
            return false;
        }
    }

    public function get_error()
    {
        return $this->last_error;
    }
} // class Email

} // if !class_exists

?>