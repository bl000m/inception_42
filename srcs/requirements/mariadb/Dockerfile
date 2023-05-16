FROM debian:buster

ARG DB_USER
ARG DB_DATABASE
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

# keeping the system up do date
# update the list of available packages
RUN apt-get update -y

# install the latest available version of installed packages
RUN apt-get upgrade -y

# Install the MariaDB server
# MariaDB is a drop-in replacement for MySQL. MariaDB is designed to be fully compatible with MySQL at the application level. 
# This means you can generally switch from using MySQL to MariaDB without making any changes to your applications or databases. 
# MariaDB aims to provide the same functionality and SQL syntax as MySQL, 
# allowing you to seamlessly transition to MariaDB while preserving compatibility with existing MySQL-based applications.
RUN apt-get install -y mariadb-server

# Create directory for MySQL runtime files
RUN mkdir -p /var/run/mysql
# Set ownership of the MySQL runtime directory to the mysql user and group
RUN chown -R mysql:mysql /var/run/mysql

# Start the MySQL service
RUN service mysql start \
# Create the database if it doesn't already exist
# the options "-u root" specify the user as "root" for the MySQL command-line client, 
# and "-e" indicates that the following argument is an SQL statement to be executed.
&&  mysql -u root -e \  
    "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"

# NB when using COPY instruction to copy files from the host machine to the Docker Image, 
# the destination directory is created automatically if it doesn't exist
COPY ./conf/mariadb.conf ./etc/mysql/mariadb.conf.d/50-server.cnf

# Port 3306 is the default port used by MariaDB for accepting client connections.
# It's commonly used when you want to connect to the MariaDB container 
# from another container or from the host machine.
EXPOSE 3306

# install dumb-init as a process supervisor, set it as the entrypoint for the container, 
# and specifie that the default command to be executed is mysqld with 
# the additional argument to bind the MySQL server to all available network interfaces.
RUN apt-get install dumb-init -y

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# mysqld is the MySQL daemon and the second argument allow connections from any IP address.
CMD ["mysqld", "--bind-address=0.0.0.0"]

# what does the MySQL daemon?
# The MySQL daemon, also known as mysqld, is responsible for managing and 
# handling connections to the MySQL database, executing SQL queries, 
# managing data storage, and enforcing security rules. It runs 
# as a background process and listens for incoming client connections, 
# allowing users or applications to interact with the MySQL database.