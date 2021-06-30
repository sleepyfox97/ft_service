#!/bin/sh

cd /var/www/wordpress/

wp core intall --allow-root \
	--url=https://192.168.10.10:5050 \
	--title=wordpress \
	--admin_user=fox \
	--admin_password=fox \
	--admin_emal=khiroshi@student.42tokyo.jp

db=$?
echo ">wordpress database :$db"
if [ $db -ne 0]; then
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
	--role=subscriber \
	--user_pass=user02

wp user create --allow-root \
	user03 \
	user03@42tokyo.jp \
	--role=contributor \
	--user_pass=user03

wp user create --allow-root \
	user03 \
	user03@42tokyo.jp \
	--role=author \
	--user_pass=user03

wp user create --allow-root \
	user04 \
	user04@42tokyo.jp \
	--role=editor \
	--user_pass=user04

nginx && php-fpm7
echo "wordpress start"
telegraf -config /etc/telegraf.conf
#tail -f /var/log/nginx/access.log


