#!/bin/sh

echo "phpmyadmin start"
php-fpm7
nginx -g "daemon off;" 
