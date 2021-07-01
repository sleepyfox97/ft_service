#!/bin/sh

cd /var/www/wordpress/

wp core install --allow-root \
	--url=https://192.168.10.10:5050 \
	--title=wordpress \
	--admin_user=fox \
	--admin_password=fox \
	--admin_email=khiroshi@student.42tokyo.jp

db=$?
echo ">wordpress database :$db"
if [ $db -ne 0 ]; then
	echo "You should wait mysql pod start"
	return 1
else
	echo "It's time to start Mysql"
fi

wp user create --allow-root \
	user01 \
	user01@42tokyo.jp \
	--role=subscriber \
	--user_pass=user01

wp user create --allow-root \
	user02 \
	user02@42tokyo.jp \
	--role=contributor \
	--user_pass=user02

telegraf -config /etc/telegraf.conf &
nginx && php-fpm7
echo "wordpress start"
tail -f /var/log/nginx/access.log


