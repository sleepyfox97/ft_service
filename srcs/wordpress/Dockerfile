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
        -out /etc/nginx/ssl/nginx-wp.crt \
        -keyout /etc/nginx/ssl/nginx-wp.key \
        -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

#Wordpress install 
WORKDIR /tmp
RUN set -ex; \
	wget --no-check-certificate https://wordpress.org/latest.tar.gz; \
	tar -xvf latest.tar.gz; \
	rm -rf latest.tar.gz; \
	mv wordpress /var/www/wordpress; 

# wp-cli
# for Wordpress user add by command
RUN set -ex; \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp


RUN rm -rf /var/cache/apk/*
##kokomade base

COPY ./srcs/wp-config.php /var/www/wordpress/
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/www.conf /etc/php7/php-fmp.d
COPY ./srcs/setup.sh /tmp/setup.sh
COPY ./srcs/telegraf.conf /etc/telegraf.conf
COPY ./srcs/liveness.sh /tmp/liveness.sh

RUN chmod -R 777 /var /tmp /etc
RUN chown -R nginx:nginx /etc/nginx

EXPOSE 5050


WORKDIR /
RUN chmod +x /tmp/setup.sh

COPY ./srcs/start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh
#CMD /tmp/start.sh

CMD /tmp/setup.sh
