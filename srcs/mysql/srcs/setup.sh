#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

if [ -d "/app/mysql" ]; then
	echo "skip command"
else
	echo "creat database"
	mysql_install_db --user=root > /dev/null
	#if ["$MYSQL_ROOT_PASSWORD" = ""]; then
	MYSQL_ROOT_PASSWORD=root
	echo "Password: $MYSQL_ROOT_PASSWORD"
	#fi

	MYSQL_DATABASE=${MYSQL_DATABASE:-"ft_service"}
	MYSQL_USER=${MYSQL_USER:-"user42"}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-"user42"}

	#tmpfile=mktmp
	#if [ ! -f "$tmpfile" ]; then
	#	return 1
	#fi

	cat > /tmp/sql << EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
EOF

#	if ["$MYSQL_DATABASE" != ""]; then
#		echo "Creating database: $MYSQL_DATABASE"
#		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tmpfile
#		
#		if [ "MYSQL_USER" != ""]; then
#			echo "Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
#			echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' INDENTIFIED BY '$MYSQL_PASSWORD';" >> $tmpfile
#		fi
#	fi

	/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/sql
	rm -f /tmp/sql
fi

/usr/bin/mysqld --user=root 
