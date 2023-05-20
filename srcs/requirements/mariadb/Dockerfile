FROM debian:buster

ARG DB_USER
ARG DB_DATABASE
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

# keeping the system up to date
RUN apt-get update -y && apt-get upgrade -y

# Set the DEBIAN_FRONTEND environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND noninteractive

# Install MariaDB server
RUN apt-get install -y mariadb-server mariadb-client

# Configure MariaDB
# RUN { \
    # echo "mariadb-server mysql-server/root_password password $DB_ROOT_PASSWORD"; \
    # echo "mariadb-server mysql-server/root_password_again password $DB_ROOT_PASSWORD"; \
    # } | debconf-set-selections

# Create directory for MySQL runtime files
RUN mkdir -p /var/run/mysql
# Set ownership of the MySQL runtime directory to the mysql user and group
RUN chown -R mysql:mysql /var/run/mysql

# Start the MySQL service
RUN service mysql start \
&& mysql -u root -e \
    "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"

# Copy the MariaDB configuration file
COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Install dumb-init as a process supervisor
RUN apt-get install dumb-init -y

