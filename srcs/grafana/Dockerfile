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
	wget https://dL.grafana.com/oss/release/grafana-7.4.5.linux-amd64.tar.gz; \
	tar -xvf grafana-7.4.5.linux-amd64.tar.gz; \
	rm grafana-7.4.5.linux-amd64.tar.gz; \
	mv grafana-7.4.5 grafana; \
	mv grafana/ /

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

COPY ./srcs/setup.sh /tmp/setup.sh
COPY ./srcs/defaults.ini /grafana/custom.ini
COPY dashboards /grafana/conf/provisioning/dashboards
COPY datasources /grafana/conf/provisioning/datasources
COPY ./srcs/telegraf.conf /etc/telegraf.conf
COPY ./srcs/liveness.sh /tmp/liveness.sh

RUN chmod +x /tmp/setup.sh
RUN chmod +x /tmp/liveness.sh
RUN chmod -R 755 /tmp

EXPOSE 3000
CMD /tmp/setup.sh
