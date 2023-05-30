FROM debian:buster

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y curl less php php-fpm php-mysql php-mysqli mariadb-client

# php config
RUN adduser --system nginx && \
    addgroup --system nginx
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

# # static website
# COPY conf/index.html /tmp/index.html
RUN apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*

# install wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY tools/configure.sh /tmp/configure.sh
ENTRYPOINT [ "sh", "/tmp/configure.sh" ]