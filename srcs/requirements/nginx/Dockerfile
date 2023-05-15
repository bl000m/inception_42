FROM debian:buster

# keeping the system up do date
# update the list of available packages
RUN apt-get update -y

# install the latest available version of installed packages
RUN apt-get upgrade -y

# install nginx web server spftware => that inable our operating syste, to receive and process HTTP(S) requests from clients (web browsers) 
# and  deliver the requested web content.  
RUN apt-get install nginx -y

# install openSSL to generate SSL key and certificate => cryptografic library 
RUN apt-get install openssl -y

# define the directory where we want the certificate and private key to be created
# WORKDIR /certs

# req => subcommand to specify that we want either a SELF SIGNED CERTIFICATE or a CSR (certificate signing request)
# -newkey rsa:2048 => we want a RSA (name of the cryptographic algorithm) key pair with a key length of 2048 bits. 
# -nodes => no password for private key
# -subj => provide subject information for the certificate (3 attributes: CN (common name), O (organization), C(country))
# -keyout key.pem=> where to store the private key (in key.pem in this case)
# -x509 =>  we want a SELF SIGNED CERTIFICATE (signed by the same entity that certifies)
# -days 365=> set validity period of the certificate to 365 days
# out cert.pem => where we want the CERTIFICATE, and PUBLIC KEY, to be stored
RUN openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/mpagani.42.fr.key -x509 -days 365 -subj "/C=FR" -out /etc/ssl/mpagani.42.fr.crt;

COPY /conf/nginx.conf /etc/nginx/sites-available/mpagani.42.fr.conf
RUN ln -s /etc/nginx/sites-available/mpagani.42.fr.conf /etc/nginx/sites-enabled/mpagani.42.fr.conf

EXPOSE 443

RUN apt-get install dumb-init -y

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["nginx", "-g", "daemon off;"]