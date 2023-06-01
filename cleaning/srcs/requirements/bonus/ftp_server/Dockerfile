# Dockerfile for setting up a FTP server using vsftpd

# vsftpd (Very Secure FTP Daemon) is an FTP server software for Unix-like systems.
# It is known for its security features and is designed to be lightweight and efficient.
# This Dockerfile installs and configures vsftpd to create a FTP server inside a Docker container.

FROM alpine:3.16

# Set the FTP user and password arguments
ARG FTP_USR \
    FTP_PWD

# Update the system and install vsftpd
RUN apk update && apk upgrade && \
    apk add --no-cache vsftpd

# Create a user for FTP access
RUN adduser -h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root

# Configure vsftpd
RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf

# Additional vsftpd configuration
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf &&\
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

# Set the working directory
WORKDIR /var/www

# Expose the FTP port
EXPOSE 21

# Start vsftpd with the configuration file
CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]
