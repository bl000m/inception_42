FROM debian:buster

ARG DB_USER=;
ARG DB_DATABASE=;
ARG DB_USER_PASSWORD=;
ARG DB_ROOT_PASSWORD=;

# keeping the system up to date
RUN apt-get update -y && apt-get upgrade -y

# Set the DEBIAN_FRONTEND environment variable to avoid interactive prompts
# ENV DEBIAN_FRONTEND noninteractive

# Install MariaDB server
RUN apt-get install -y mariadb-server 
#mariadb-client

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
RUN service mysql start && mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"
#RUN service mysql stop

# Copy the MariaDB configuration file
COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Expose the default MariaDB port
EXPOSE 3306

# # Install dumb-init as a process supervisor
RUN apt-get install dumb-init -y

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["mysqld", "--bind-address=0.0.0.0"]

# FROM debian:buster

# RUN apt-get update
# RUN apt-get install -y mariadb-server \
#     mariadb-client \
#     vim \
#     && rm -rf /var/lib/apt/lists/*

# #Allow to run the daemon of mysql
# # Purge and re-create /var/lib/mysql with appropriate ownership
# # ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
# RUN mkdir -p /var/run/mysqld \
# && chown -R mysql:mysql /var/run/mysqld \
# && chmod 777 /var/run/mysqld

# EXPOSE 3306

# #COPY		./conf/mysqld.conf ~/my.cnf
# #COPY		./conf/mysqld.conf /etc/mysql/my.cnf
# #COPY		./conf/mysqld.conf /etc/my.cnf


# #Copy of the .sh and .sql in the /bin of the container to be able to run the program
# # Give the right to execute + launch the .sh
# COPY ./tools/mariadb.sh /usr/local/bin/
# COPY ./conf/wordpress.sql /usr/local/bin/
# RUN chmod +x /usr/local/bin/mariadb.sh
# RUN chmod +x /usr/local/bin/wordpress.sql

# ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

# #Command to launch mariadb and enable the database to listen globally - also can be put on mysqldump.cnf file
# CMD ["mysqld", "--bind-address=0.0.0.0"]