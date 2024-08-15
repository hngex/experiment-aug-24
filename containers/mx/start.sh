#!/bin/sh

LOG_FILE=/var/log/postfix.log
MAILBOX=/var/mail/vhosts

postconf -e myhostname="$(hostname)"
#postconf -e mynetworks='127.0.0.0/8 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
#postconf -e smtp_host_lookup='native'
#postconf -e smtp_dns_support_level='disabled'
postconf -e mynetworks='127.0.0.0/8'
postconf -e default_process_limit='5'
postconf -e maillog_file=$LOG_FILE
postconf -e inet_protocols='ipv4'

# Enable self-host sending an Escape mail looping
postconf -e mydomain="${MYDOMAIN}"
postconf -e mydestination='$myhostname, localhost.$mydomain, localhost'
postconf -e bounce_queue_lifetime='0'
postconf -e maximal_queue_lifetime='0'

# Set up mail account
groupadd -g 5000 vmail
useradd vmail -u 5000 -g 5000 -m -s /sbin/nologin
postconf -e virtual_uid_maps='static:5000'
postconf -e virtual_gid_maps='static:5000'
postconf -e virtual_mailbox_domains="${MYDOMAIN}"
postconf -e virtual_mailbox_maps="hash:/etc/postfix/vmailbox"
postconf -e virtual_mailbox_base="${MAILBOX}"
mkdir -p ${MAILBOX}/${MYDOMAIN}/bob
chown -R vmail:mail ${MAILBOX}/${MYDOMAIN}/bob
cat <<EOF > /etc/postfix/vmailbox
bob@${MYDOMAIN} ${MYDOMAIN}/bob/
EOF
postmap /etc/postfix/vmailbox

# Name resolutions in Posffix
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

tail -f $LOG_FILE &
exec /usr/sbin/postfix start-fg
