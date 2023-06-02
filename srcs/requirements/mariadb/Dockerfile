# to check mysql within mariadb container: mysql -u root -p 
# SHOW DATABASES;
# use 'wordpress';
# SHOW TABLES;
# SELECT wp_users.display_name FROM wp_users; 
# SELECT * FROM wp_users;

FROM debian:buster

ARG DB_USER
ARG DB_DATABASE
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

# Update and upgrade packages
RUN apt-get update -y && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install -y mariadb-server

# Create directory for MySQL run files and set permissions
RUN mkdir -p /var/run/mysql && \
    chown -R mysql:mysql /var/run/mysql

# Start the MySQL service and configure the database
RUN service mysql start && \
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"

# Copy MariaDB configuration file
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

# Install dumb-init as the init system
RUN apt-get install -y dumb-init

# Set the entrypoint and default command to start the MariaDB service
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["mysqld", "--bind-address=0.0.0.0"]
