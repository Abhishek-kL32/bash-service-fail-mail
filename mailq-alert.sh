#!/bin/bash
email="abhishek@spotfixcrew.com"
NUM=`mailq | grep -E "Requests" | awk '{print $5}'`; if [ -z "$NUM" ]; then echo "0"; else echo $NUM; fi > /home/ubuntu/iRedMail/mail-qeue-num
if [ `sort -nr /home/ubuntu/iRedMail/mail-qeue-num | head -1` -ge 100 ]
then
    SUBJECT="mailq alert on $(hostname) $(date) "
    echo " mail Queu is more than 100 in $(hostname)  "  | mail -s "$SUBJECT" "$EMAIL"
fi
