#!/bin/bash

set -e

AUTOMATION_EMAIL=$(awk -F '=' '/AUTOMATION_EMAIL/ { gsub("\"", "", $2); print $2 }' .env)
AUTOMATION_NAME=$(awk -F '=' '/AUTOMATION_NAME/ { gsub("\"", "", $2); print $2 }' .env)
RECORDED_IP=$(awk -F '=' '/RECORDED_IP/ { gsub("\"", "", $2); print $2 }' .env)
REPORT_EMAIL=$(awk -F '=' '/REPORT_EMAIL/ { gsub("\"", "", $2); print $2 }' .env)
SMTP_PASSWORD=$(awk -F '=' '/SMTP_PASSWORD/ { gsub("\"", "", $2); print $2 }' .env)

docker build \
  --build-arg AUTOMATION_EMAIL="$AUTOMATION_EMAIL" \
  --build-arg AUTOMATION_NAME="$AUTOMATION_NAME" \
  --build-arg RECORDED_IP="$RECORDED_IP" \
  --build-arg REPORT_EMAIL="$REPORT_EMAIL" \
  --build-arg SMTP_PASSWORD="$SMTP_PASSWORD" \
  -t dipc_img .

docker run --rm -d -v ./logs:/app/logs --name dipc_container dipc_img
