#!/bin/sh
telegraf -config /etc/telegraf.conf &
nginx -g "daemon off;"
