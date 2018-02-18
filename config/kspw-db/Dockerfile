FROM mysql:5.7

RUN apt-get update -y && apt-get install -y cron nano wget curl

ADD ./bin /home/bin
ADD ./cron /etc/cron.d
ADD ./database /home

RUN wget https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh -P /usr/bin && \
    chmod +x /usr/bin/dropbox_uploader.sh

# Combine individual cron files into single cron file and load into crontab
RUN cat /etc/cron.d/backup-db.cron > /etc/cron.d/combined.cron && \
    cat /etc/cron.d/remove-backups.cron >> /etc/cron.d/combined.cron && \
    cat /etc/cron.d/upload-cloud.cron >> /etc/cron.d/combined.cron && \
    crontab /etc/cron.d/combined.cron

RUN bash /home/bin/restore_backup.sh
