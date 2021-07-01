pgrep vsftpd
liveness=$?
if [ $liveness -ne 0 ]; then
	return 1
fi

pgrep telegraf
liveness=$?
if [ $liveness -ne 0 ]; then
	return 1
fi
