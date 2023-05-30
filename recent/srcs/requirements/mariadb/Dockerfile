# FROM debian:buster

# RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
#     mariadb-server \
#     mariadb-client
        
# COPY tools/configure.sh /tmp/configure.sh

# ENTRYPOINT ["sh", "/tmp/configure.sh"]

FROM debian:buster


RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/configure.sh /

RUN chmod +x /configure.sh


CMD ["/configure.sh"]