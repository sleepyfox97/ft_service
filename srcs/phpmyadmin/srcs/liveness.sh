pgrep telegraf
liveness_php=$?
if [ $liveness_php -ne 0 ]; then
	return 1
fi

pgrep php
liveness_php=$?
if [ $liveness_php -ne 0 ]; then
	return 1
fi

pgrep nginx
liveness_php=$?
if [ $liveness_php -ne 0 ]; then
	return 1
fi
