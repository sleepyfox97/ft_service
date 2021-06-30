#!/bin/sh
#tail -f
telegraf -config /etc/telegraf.conf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
