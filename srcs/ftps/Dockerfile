FROM alpine:3.13

LABEL com.42tokyo.vendor="sleepyfox"

RUN set -eux; \
        apk -U upgrade; \
        apk add --no-cache \
                nginx \
		openssl \
		wget \
		curl; \
	apk add --no-cache mysql mysql-client; \
	apk add --no-cache php7-phar php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom; \
	apk add openrc mandoc man-pages; \
	apk add vsftpd; \
	# grafana-server
	apk add libc6-compat; \
	apk add influxdb telegraf
	
RUN set -eux; \
        mkdir -p /var/run/nginx

RUN set -eux; \
        mkdir /etc/nginx/ssl && \
        openssl req -newkey rsa:2048 \
        -x509 \
        -sha256 \
        -days 365 \
        -nodes \
        -out /etc/nginx/ssl/ft_service.crt \
        -keyout /etc/nginx/ssl/ft_service.key \
        -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

RUN rm -rf /var/cache/apk/*
##kokomade base

RUN adduser -D ftp-user && echo 'ftp-user:ftp-user' | chpasswd

RUN mkdir -p /var/www/ftp_dir \
    chown ftp-user /var/www/ftp_dir \
    chmod 755 /var/www/ftp_dir

RUN mkdir -p /etc/vsftpd/user_conf

RUN touch /var/log/vsftpd.log

COPY ./srcs/setup.sh /tmp/setup.sh

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/chroot_list /etc/vsftpd/chroot_list
COPY ./srcs/telegraf.conf /etc/telegraf.conf
COPY ./srcs/liveness.sh /liveness.sh

RUN chmod +x /liveness.sh
RUN chmod -R 777 /tmp /var /etc
EXPOSE 20 21 60000

WORKDIR /
CMD /tmp/setup.sh
