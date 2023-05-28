FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client
        
COPY tools/configure.sh /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]