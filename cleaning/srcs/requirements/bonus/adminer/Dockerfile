# Dockerfile for setting up a PHP environment with Adminer

FROM alpine:3.15.0

# To check if it's working, access the following URL in a web browser: mpagani.42.fr/adminer
# System: MySQL
# Server: DB_HOST
# User: DB_USER
# Password: DB_USER_PASSWORD
# Database: DB_DATABASE

# Install prerequisites for PHP environment
RUN apk update && \
    apk add --no-cache \
    curl \
    less \
    mariadb-client \
    php8 \
    php8-fpm \
    php8-common \
    php8-session \
    php8-iconv \
    php8-json \
    php8-gd \
    php8-curl \
    php8-xml \
    php8-mysqli \
    php8-imap \
    php8-pdo \
    php8-pdo_mysql \
    php8-soap \
    php8-posix \
    php8-gettext \
    php8-ldap \
    php8-ctype \
    php8-dom \
    php8-simplexml

# Run the Adminer setup
RUN \
    curl -L -O https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    mkdir -p /var/www/html && \
    mv ./adminer-4.8.1.php /var/www/html/index.php && \
    adduser -u 82 -D -S -G www-data www-data

# Copy the www.conf file for PHP-FPM configuration
COPY /conf/www.conf /etc/php8/php-fpm.d/www.conf

# Expose the PHP-FPM port
EXPOSE 9000

# Set the stop signal for PHP-FPM
STOPSIGNAL SIGQUIT

# Start PHP-FPM in non-daemon mode
CMD ["php-fpm8", "--nodaemonize"]
