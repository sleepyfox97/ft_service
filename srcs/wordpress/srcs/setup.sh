#!/bin/sh

cd /var/www/wordpress/

wp core intall --allow-root \
	--url=https://192.168.10.10:5050 \
	--title=wordpress \
	--admin_user=fox \
	--admin_password=fox \
	--admin_emal=khiroshi@student.42tokyo.jp

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
	--role=subscriber \
	--user_pass=user03

wp user create --allow-root \
	user03 \
	user03@42tokyo.jp \
	--role=subscriber \
	--user_pass=user03

wp user create --allow-root \
	user04 \
	user04@42tokyo.jp \
	--role=subscriber \
	--user_pass=user04

nginx && php-fpm7
echo "wordpress start"
tail -f /var/log/nginx/access.log


