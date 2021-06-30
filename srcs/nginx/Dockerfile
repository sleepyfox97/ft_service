FROM alpine:3.13

#FROM baseimg
LABEL com.42tokyo.vendor="sleepyfox"

RUN set -eux; \
        apk -U upgrade; \
        apk add --no-cache \
                nginx \
                openssl \
                openssh; \
	# grafana-server
        apk add libc6-compat; \
        apk add influxdb telegraf

#why this line is needed?
RUN set -eux; \
        mkdir -p /var/run/nginx

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY srcs/index.html /var/www/localhost/index.html
RUN chmod 644 /var/www/localhost/index.html

RUN set -eux; \
        mkdir /etc/nginx/ssl && \
        openssl req -newkey rsa:2048 \
        -x509 \
        -sha256 \
        -days 365 \
        -nodes \
        -out /etc/nginx/ssl/nginx-ssl.crt \
        -keyout /etc/nginx/ssl/nginx-ssl.key \
        -subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=student/CN=localhost"

COPY srcs/telegraf.conf ./etc/telegraf.conf
COPY srcs/setup.sh /tmp/

RUN chown -R nginx:nginx /etc/nginx

# execution permission is needed
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh

# port
EXPOSE 80 443 22
