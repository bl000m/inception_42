FROM debian:buster

# Update and upgrade packages
RUN apt-get update -y && apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y curl less php php-fpm php-mysql php-mysqli mariadb-client redis php-redis dumb-init

# Download and set up WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy static website files
COPY conf/index.html /tmp/index.html
COPY conf/style.css /tmp/style.css
COPY conf/images /tmp/images

# Create WordPress installation directory
RUN mkdir -p /var/www/html/wordpress

# Copy install script and configuration file
COPY tools/launch_wordpress.sh /tmp
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

# Use dumb-init as the entrypoint to handle signals and reaping zombies,
# and specify the command to run the launch script
ENTRYPOINT ["/usr/bin/dumb-init", "--", "sh", "/tmp/launch_wordpress.sh"]
