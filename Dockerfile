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

# Set document root to the application root (not public)
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Update Apache configuration to point to the correct document root
RUN sed -ri -e 's!/var/www/html!/var/www/html!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!/var/www/html!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Create Apache virtual host configuration
RUN echo '<VirtualHost *:80>\n\
    ServerAdmin webmaster@localhost\n\
    DocumentRoot /var/www/html\n\
    \n\
    <Directory /var/www/html>\n\
        Options -Indexes +FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    \n\
    ErrorLog \$\{APACHE_LOG_DIR\}/error.log\n\
    CustomLog \$\{APACHE_LOG_DIR\}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]
