FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl less
RUN apt-get install -y php

# Install PHP-FPM (FastCgi process manager)
    # define how NGINX communicate with CGI program (php)
RUN apt-get install -y php-fpm

RUN apt-get install -y php-mysql

# Improved driver
RUN apt-get install -y php-mysqli

# Install mariadb client to connect to the database
RUN apt-get install -y mariadb-client

# Download WP-CLI and set execution permission
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&&		chmod +x wp-cli.phar \
&&		mv wp-cli.phar /usr/local/bin/wp


# Create wordpress installation directory
RUN mkdir -p /var/www/html/wordpress

# Copy install script to /tmp
COPY	/tools/launch_wordpress.sh /tmp

# Copy configuration file
COPY	/conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/tmp/launch_wordpress.sh"]