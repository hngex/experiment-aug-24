#!/bin/sh

LOG_FILE=/var/log/postfix.log

postconf -e myhostname="$(hostname)"
postconf -e mynetworks='127.0.0.0/8 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
postconf -e default_process_limit='5'
postconf -e maillog_file=$LOG_FILE
postconf -e inet_protocols='ipv4'
#postconf -e mynetworks='127.0.0.1'
#postconf -e smtp_host_lookup='native'
#postconf -e smtp_dns_support_level='disabled'

# Debug
#postconf -e debug_peer_list='192.168.0.0/16'
#postconf -e debug_peer_level='3'

# Name resolutions in Posffix
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

# Enable self-host sending an Escape mail looping
postconf -e mydestination='localhost'
postconf -e bounce_queue_lifetime='0'
postconf -e maximal_queue_lifetime='0'

tail -f $LOG_FILE &
exec /usr/sbin/postfix start-fg
