FROM debian:buster

# keeping the system up do date
# update the list of available packages
RUN apt-get update -y

# install the latest available version of installed packages
RUN apt-get upgrade -y

# install Curl (Curl is a command-line tool and a library used to make HTTP requests and interact 
# with various protocols, including HTTP, HTTPS, FTP, SCP, SFTP, and more.)
RUN apt-get install curl -y less

# Install PHP for server-side scripting and handling PHP requests.
# PHP is a popular general-purpose scripting language widely used in web development.
# It allows you to dynamically generate web content, interact with databases, handle form submissions, and more.
# Installing PHP enables your server to process PHP files and serve dynamic web pages to clients.

RUN apt-get install php -y

# Install PHP-FPM (PHP FastCGI Process Manager) for efficient processing of PHP requests in a server environment.
# PHP-FPM acts as a middle layer between the web server and the PHP interpreter, managing PHP processes and handling incoming requests.
# It helps improve performance by keeping PHP processes persistent, avoiding the overhead of initializing PHP for each request.
# PHP-FPM provides process-level isolation, running PHP scripts with specific user privileges and resource limits, enhancing security and stability.
# Additionally, it allows fine-grained configuration options for maximum connections, process pools, and various PHP runtime parameters.
RUN apt-get install php-fpm -y

# Install PHP-MySQL extension for connecting PHP with MySQL databases.
# PHP-MySQL extension allows PHP scripts to communicate with MySQL databases, enabling database operations such as querying, inserting, updating, and deleting data.
# It provides a set of functions and features that simplify the interaction with MySQL databases from PHP code.
# By installing the PHP-MySQL extension, you can seamlessly integrate your PHP applications with MySQL databases, facilitating data-driven web development.
RUN apt-get install php-mysql -y

# Install PHP MySQLi extension for MySQL database connectivity.
# Enables PHP to interact with MySQL databases using the MySQLi extension.
# The MySQLi extension provides enhanced functionality for interacting with MySQL databases in PHP, including improved security and support for advanced features.
RUN apt-get install php-mysqli

# Install MariaDB client for interacting with MariaDB or MySQL databases.
# The MariaDB client provides command-line tools to connect, query, and manage databases, facilitating database administration tasks.

RUN apt-get install mariadb-client

# req => subcommand to specify that we want either a SELF SIGNED CERTIFICATE or a CSR (certificate signing request)
# -newkey rsa:2048 => we want a RSA (name of the cryptographic algorithm) key pair with a key length of 2048 bits. 
# -nodes => no password for private key
# -subj => provide subject information for the certificate (3 attributes: CN (common name), O (organization), C(country))
# -keyout key.pem=> where to store the private key (in key.pem in this case)
# -x509 =>  we want a SELF SIGNED CERTIFICATE (signed by the same entity that certifies)
# -days 365=> set validity period of the certificate to 365 days
# out cert.pem => where we want the CERTIFICATE, and PUBLIC KEY, to be stored

# WP-CLI is the command-line interface for WordPress. You can update plugins, 
# configure multisite installations and much more, without using a web browser.
# => HOW TO INSTALL IT: https://make.wordpress.org/cli/handbook/guides/installing/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


run MKDIR -P /var/www/html/wordpress

EXPOSE 9000

# NB when using COPY instruction to copy files from the host machine to the Docker Image, 
# the destination directory is created automatically if it doesn't exist

# copy wordpress installation cmds to tmp docker folder => not persistent and not visible
COPY /tools/installing_wordpress.sh /tmp

# copy the PHP-FPM (FastCGI Process Manager) config file containing all the directives that control the behavior of PHP-FPM
# to PHP pool folder (created installing PHP ?) 
COPY /tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN apt-get install dumb-init -y

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/tmp/installing_wordpress.sh"]