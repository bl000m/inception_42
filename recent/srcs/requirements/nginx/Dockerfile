FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    nginx \
    openssl


# nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/mpagani.pem \
        -keyout /etc/nginx/ssl/mpagani.key \
        -subj "/C=FR/O=42 School/OU=mpagani/CN=mpagani/"

# nginx config
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]