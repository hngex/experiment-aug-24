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

send "5871" "from@msa1.local" "to@mx1.local" &
send "5872" "from@msa2.local" "to@mx2.local" &
send "5873" "from@msa3.local" "to@mx3.local" &

echo
