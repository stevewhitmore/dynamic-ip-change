#!/bin/bash

RECORDED_IP=$(awk -F '=' '/RECORDED_IP/ { gsub("\"", "", $2); print $2 }' /app/script.env)
REPORT_EMAIL=$(awk -F '=' '/REPORT_EMAIL/ { gsub("\"", "", $2); print $2 }' /app/script.env)

current_ip=$(curl -s4 ifconfig.me)

output=$(
    date
    echo "current IP: $current_ip"
    echo "recorded IP: $RECORDED_IP"
    echo "#############"
)

echo -e "$output\n"

if [[ $current_ip != $RECORDED_IP ]]; then
    echo -e "IP Address has changed. \n $output" \
    | mutt -s "IP Address has changed" "$REPORT_EMAIL"
fi