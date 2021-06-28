F
#!/bin/sh

# if  derectory dosen't exist, mysqld can't start
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

if [ -d "/app/mysql/ft_service" ]; then
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
	touch /tmp/sql
	
	cat > /tmp/sql << EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
EOF

	echo "Creating database: $MYSQL_DATABASE"
	echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> /tmp/sql
		
	echo "Creating user: $MYSQL_USER with password: $MYSQL_PASSWORD"
	echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /tmp/sql


	/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/sql
	rm -f /tmp/sql
fi

#excute database
/usr/bin/mysqld --user=root --datadir=/app/mysql 
