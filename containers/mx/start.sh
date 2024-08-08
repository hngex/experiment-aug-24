#!/bin/sh +x

LOG_FILE=/var/log/postfix.log

postconf -e myhostname="$(hostname)"
postconf -e mynetworks='127.0.0.0/8 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
postconf -e smtp_host_lookup='native'
postconf -e smtp_dns_support_level='disabled'
postconf -e default_process_limit='5'
postconf -e maillog_file=$LOG_FILE
postconf -e inet_protocols='ipv4'

mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

tail -f $LOG_FILE | tee /dev/stdout &

exec /usr/sbin/postfix start-fg
