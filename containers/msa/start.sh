#!/bin/sh

LOG_FILE=/var/log/postfix.log

postconf -e myhostname="$(hostname)"
postconf -e mynetworks='127.0.0.0/8 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
postconf -e smtp_host_lookup='native'
postconf -e smtp_dns_support_level='disabled'
postconf -e default_process_limit='5'
postconf -e maillog_file=$LOG_FILE
postconf -e inet_protocols='ipv4'
#postconf -e debug_peer_list='192.168.0.0/16'
#postconf -e debug_peer_level='3'

cat <<EOF >> /etc/postfix/master.cf
submission inet n       -       y       -       -       smtpd
  #-o syslog_name=postfix/submission
  #-o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  #-o smtpd_recipient_restrictions=permit_sasl_authenticated,reject
  #-o smtpd_relay_restrictions=permit_sasl_authenticated,reject
EOF

#cat <<EOF >> /etc/hosts
#172.18.0.10   msa1.local
#172.18.0.11   msa2.local
#172.18.0.12   msa3.local
#172.18.1.10   mx1.local
#172.18.1.11   mx2.local
#172.18.1.12   mx3.local
#EOF

# Name resolutions in Posffix
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

tail -f $LOG_FILE | tee /dev/stdout &

exec /usr/sbin/postfix start-fg
