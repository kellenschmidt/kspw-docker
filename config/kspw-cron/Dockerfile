FROM alpine:3.7

ARG OAUTH_ACCESS_TOKEN

RUN apk update && apk add --no-cache mysql-client wget bash curl

ADD ./bin /home/bin
RUN chmod +x /home/bin/*.sh
ADD ./cron /home/cron
RUN mkdir /home/backups
RUN printenv > /etc/environment

RUN wget https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh -P /usr/bin && \
    chmod +x /usr/bin/dropbox_uploader.sh

# Combine individual cron files into single cron file and load into crontab
RUN cat /home/cron/backup-db.cron > /home/cron/combined_cron && \
    cat /home/cron/remove-backups.cron >> /home/cron/combined_cron && \
    cat /home/cron/upload-cloud.cron >> /home/cron/combined_cron && \
    crontab /home/cron/combined_cron

ENTRYPOINT [ "crond", "&&", "tail", "-f", "/dev/null" ]
