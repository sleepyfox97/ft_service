#!/bin/sh
#tail -f
telegraf -config /etc/telegraf.conf &
/grafana/bin/grafana-server -homepath /grafana --config /grafana/custom.ini
