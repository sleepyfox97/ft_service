pgrep nginx
liveness_wp=$?
if [ $liveness_wp -ne 0 ]; then
	return 1
fi

pgrep php
liveness_wp=$?
if [ $liveness_wp -ne 0 ]; then
	return 1
fi

pgrep telegraf
liveness_wp=$?
if [ $liveness_wp -ne 0 ]; then
	return 1
fi

pgrep tail
liveness_wp=$?
if [ $liveness_wp -ne 0 ]; then
	return 1
fi
