#!/bin/sh

if [ ! -d "/run/mysql" ]; then
	mkdir -p /run/mysql
fi

if [ -d "/app/mysql" ]; then
	echo "skip command"
else
	echo "creat database"

	mysql_install_db --user=root > /dev/null

	if 
