#!/bin/sh

LOG_FILE=/var/log/mxtarpit.log

/usr/sbin/mxtarpit -F 2>&1 | tee -a $LOG_FILE
