FROM mysql:5.7

RUN apt-get update -y && apt-get install -y cron nano wget curl

ADD ./bin /home/bin
RUN chmod +x /home/bin/*.sh
ADD ./cron /home/cron
ADD ./database/backups /home/backups

RUN wget https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh -P /usr/bin && \
    chmod +x /usr/bin/dropbox_uploader.sh

# Combine individual cron files into single cron file and load into crontab
RUN cat /home/cron/backup-db.cron > /home/cron/combined_cron && \
    cat /home/cron/remove-backups.cron >> /home/cron/combined_cron && \
    cat /home/cron/upload-cloud.cron >> /home/cron/combined_cron && \
    crontab /home/cron/combined_cron
