FROM alpine:3.12

LABEL com.42tokyo.vendor="sleepyfox"

RUN set -eux; \
        apk -U upgrade; \
        apk add --no-cache \
                nginx \
		openssl \
		wget \
		curl; \
	apk add --no-cache mysql mysql-client; \
	apk add --no-cache php7-phar php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

#why this line is needed?
RUN set -eux; \
        mkdir -p /var/run/nginx
# Really need above two line?


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

Wordpress install 
WORKDIR /tmp
RUN set -ex; \
	wget --no-check-certificate https://wordpress.org/latest.tar.gz; \
	tar -xvf latest.tar.gz; \
	rm -rf latest.tar.gz; \
	mv wordpress /var/www/wordpress; 
	#mv wp-config.php /var/www/html/wordpress; \

RUN set -ex; \
	wget -O phpmyadmin.tar.gz --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz; \
	tar -xvf phpmyadmin.tar.gz; \
	mv phpMyAdmin-5.0.2-all-languages /var/www/phpmyadmin; \
	rm -rf  phpmyadmin.tar.gz; 

wp-cli
for Wordpress user add by command
RUN set -ex; \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp


RUN rm -rf /var/cache/apk/*
##kokomade base


COPY ./srcs/setup.sh /tmp/
COPY mariadb-server.cnf /etc/my.cnf.d

RUN chmod -R 755 /tmp

RUN chown -R nginx:nginx /etc/nginx

EXPOSE 3306

RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
