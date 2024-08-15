#!/bin/bash

SLEEP=1
SMTP_SERVER="localhost"
MAIL_SUBJECT="Test Email"
MAIL_BODY="This is a test email sent in a shell script."

send () {
  SMTP_PORT=$1
  MAIL_FROM=$2
  RCPT_TO=$3
  {
    sleep $SLEEP
    echo "HELO localhost"
    sleep $SLEEP
    echo "MAIL FROM:<$MAIL_FROM>"
    sleep $SLEEP
    echo "RCPT TO:<$RCPT_TO>"
    sleep $SLEEP
    echo "DATA"
    sleep $SLEEP
    echo "Subject: $MAIL_SUBJECT"
    echo "$MAIL_BODY"
    echo "."
    sleep $SLEEP
    echo "QUIT"
  } | telnet $SMTP_SERVER $SMTP_PORT
  #} | openssl s_client -quiet -starttls smtp -crlf -connect $SMTP_SERVER:$SMTP_PORT -ign_eof
}

#send "5871" "alice@msa1.local" "bob@ex228.warpmail.dev" &
#send "5872" "carol@msa2.local" "bob@ex229.warpmail.dev" &
#send "5873" "mallory@msa3.local" "bob@ex230.warpmail.dev" &

send "5871" "alice@msa1.local" "bob@mx1.local" &
send "5872" "carol@msa2.local" "bob@mx2.local" &
send "5873" "mallory@msa3.local" "bob@mx3.local" &

echo
