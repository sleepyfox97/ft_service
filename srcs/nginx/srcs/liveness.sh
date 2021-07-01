pgrep nginx
liveness_nginx=$?
if [ $liveness_nginx -ne 0 ]; then
	return 1
fi

pgrep telegraf
liveness_nginx=$?
if [ $liveness_nginx -ne 0 ]; then
	return 1
fi
