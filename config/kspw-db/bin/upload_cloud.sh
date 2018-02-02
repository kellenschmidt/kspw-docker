#!/bin/bash

# Arguments
# 

newestBackup=$(ls -t /home/db-backups | head -1)
echo "Newest backup: ${newestBackup}" >> /var/log/cron.log
dropbox_uploader.sh -f /etc/environment upload /home/db-backups/${newestBackup} ./
# dropbox_uploader.sh -f /etc/environment upload "$(ls -t /home/db-backups | head -1)" ./

