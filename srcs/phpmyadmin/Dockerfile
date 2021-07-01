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
        -out /etc/nginx/ssl/nginx-php.crt \
        -keyout /etc/nginx/ssl/nginx-php.key \
        -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

RUN set -ex; \
	wget -O phpmyadmin.tar.gz --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz; \
	tar -xvf phpmyadmin.tar.gz; \
	mv phpMyAdmin-5.0.2-all-languages /var/www/phpmyadmin; \
	mkdir /var/www/phpmyadmin/tmp; \
	rm -rf  phpmyadmin.tar.gz; 


RUN rm -rf /var/cache/apk/*
##kokomade base


COPY ./srcs/setup.sh /tmp/
COPY ./srcs/liveness.sh /tmp/liveness.sh
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/config.inc.php /var/www/phpmyadmin

#COPY ./srcs/info.php /var/www/phpmyadmin

COPY ./srcs/www.conf /etc/php7/php-fmp.d
COPY ./srcs/telegraf.conf /etc/telegraf.conf

RUN chmod -R 755 /var /etc
RUN chmod -R 777 /tmp
RUN chmod -R 777 /var/www/phpmyadmin/tmp

RUN chown -R nginx:nginx /etc/nginx

EXPOSE 5000

RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh

