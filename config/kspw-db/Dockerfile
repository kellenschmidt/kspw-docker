FROM mysql:5.7

RUN apt-get update -y && apt-get install -y cron nano wget curl

ADD ./bin /home/bin
ADD ./cron /etc/cron.d

RUN wget https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh -P /usr/bin
RUN chmod +x /usr/bin/dropbox_uploader.sh

# Combine individual cron files into single cron file
RUN cat /etc/cron.d/backup-db.cron > /etc/cron.d/combined.cron
RUN cat /etc/cron.d/remove-backups.cron >> /etc/cron.d/combined.cron
RUN cat /etc/cron.d/upload-cloud.cron >> /etc/cron.d/combined.cron

# Add Cron commands to crontab
RUN crontab /etc/cron.d/combined.cron

# Restart cron
# RUN /etc/init.d/cron start >> /var/log/cron.start.log
CMD cron -f