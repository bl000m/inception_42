FROM debian:buster

# Update and Upgrade packages | -y to accept everything
RUN apt-get update -y && apt-get -y upgrade

# Install nginx and openssl
RUN apt-get install -y nginx openssl

# Generate SSL Key and certificate
RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR -keyout /etc/ssl/mpagani.42.fr.key -out /etc/ssl/mpagani.42.fr.crt
#   req                 - Used for generating certificate signing requests (CSRs) and self-signed certificates
#   -x509               - We want a self-signed certificate rather than a CSR
#   -newkey rsa:2048    - Generate a RSA key pair with a key length of 2048 bits
#   -nodes              - We do not want to encrypt the the private key with a passphrase -> no decryption needed
#   - subj /C=FR        - Subject of the certificate -> country code FR (used to identify the identity that the certificate belongs to)
#   - keyout <path>     - Path and filename for the private key
#   - out <path>        - Path and filename for the self-signed certificate

# # NGINX conf file
COPY /conf/nginx.conf /etc/nginx/sites-available/mpagani.42.fr.conf
RUN ln -s /etc/nginx/sites-available/mpagani.42.fr.conf /etc/nginx/sites-enabled/mpagani.42.fr.conf

# Port 443
EXPOSE 443

# Install DUMB-INIT
# dumb-init runs as PID 1, acting like a simple init system.
# It launches a single process and then proxies all received signals to a session rooted at that child process.
RUN apt-get install -y dumb-init

# CMD command will be passed as argument to ENTRYPOINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# -g flag -> set global directive or variables
# daemon off directive -> NGINX stay in the foreground
CMD ["nginx", "-g", "daemon off;"]