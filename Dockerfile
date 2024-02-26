FROM python:3.12.1-bookworm

WORKDIR /app

COPY . .

# Install cron, vim, and mutt
RUN apt update && apt install -y cron vim mutt

ARG AUTOMATION_EMAIL
ARG AUTOMATION_NAME
ARG SMTP_PASSWORD
ARG RECORDED_IP
ARG REPORT_EMAIL

RUN cat <<EOF > /app/script.env
RECORDED_IP="$RECORDED_IP"
REPORT_EMAIL="$REPORT_EMAIL"
EOF

RUN cat <<EOF > /root/.muttrc
set from = "$AUTOMATION_EMAIL"
set realname = "$AUTOMATION_NAME"
set smtp_url = "smtp://${AUTOMATION_EMAIL}@smtp.gmail.com:587/"
set smtp_pass = "$SMTP_PASSWORD"
EOF

# Set timezone
ENV TZ="America/Chicago"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup crontab
RUN crontab -l | { cat; echo '05 0 * * 1-5 /app/check.sh > /app/logs/`date +\%Y-\%m-\%d.log`'; } | crontab -

CMD cron && tail -f /dev/null