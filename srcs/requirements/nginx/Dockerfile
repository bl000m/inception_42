FROM debian:buster

# Update and upgrade packages
RUN apt-get update -y && apt-get -y upgrade

# Install nginx and openssl
RUN apt-get install -y nginx openssl

# Generate SSL Key and certificate
RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR -keyout /etc/ssl/mpagani.42.fr.key -out /etc/ssl/mpagani.42.fr.crt
#   req                 - Generate certificate signing requests (CSRs) and self-signed certificates
#   -x509               - Create a self-signed certificate instead of a CSR
#   -newkey rsa:2048    - Generate a new RSA key pair with a length of 2048 bits
#   -nodes              - Do not encrypt the private key with a passphrase
#   -subj /C=FR         - Set the subject of the certificate to "FR" (France)

# Copy NGINX conf file
COPY conf/nginx.conf /etc/nginx/sites-available/mpagani.42.fr.conf
RUN ln -s /etc/nginx/sites-available/mpagani.42.fr.conf /etc/nginx/sites-enabled/mpagani.42.fr.conf

EXPOSE 443

# dumb-init runs as PID 1, acting like a simple init system.
RUN apt-get install -y dumb-init

# CMD command will be passed as argument to ENTRYPOINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# -g flag -> global
# daemon off -> background
CMD ["nginx", "-g", "daemon off;"]

# The self-signed certificate triggers browser security alerts
# as it is not issued by a trusted certificate authority (CA)
# and browsers consider it potentially insecure.
# However, it can still be used for testing and development purposes.
# For production environments, it is recommended to use a valid SSL certificate from a trusted CA.
