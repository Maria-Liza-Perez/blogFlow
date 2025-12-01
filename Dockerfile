FROM composer:2 AS build

WORKDIR /app

# Copy composer files
COPY composer.json ./
COPY composer.lock* ./

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress --ignore-platform-reqs

# Copy the rest of the application
COPY . .

FROM php:8.2-apache

WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Copy application files from build stage
COPY --from=build /app /var/www/html

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/public/uploads \
    && mkdir -p /var/www/html/runtime/logs \
    && mkdir -p /var/www/html/runtime/cache \
    && chown -R www-data:www-data /var/www/html/public/uploads \
    && chown -R www-data:www-data /var/www/html/runtime \
    && chmod -R 755 /var/www/html/public/uploads \
    && chmod -R 755 /var/www/html/runtime

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && echo "ServerTokens Prod" >> /etc/apache2/apache2.conf \
    && echo "ServerSignature Off" >> /etc/apache2/apache2.conf

# Set document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Create Apache virtual host configuration using cat with heredoc
RUN cat > /etc/apache2/sites-available/000-default.conf <<'EOF'
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

EXPOSE 80

CMD ["apache2-foreground"]

# Cache bust: 20251201-235123
