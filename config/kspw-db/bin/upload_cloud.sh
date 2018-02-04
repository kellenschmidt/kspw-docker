#!/bin/bash

# Arguments
# None

newestBackup=$(ls -t /home/db-backups | head -1)

dropbox_uploader.sh -f /etc/environment upload /home/db-backups/${newestBackup} ./ >> /var/log/cron.log
