#!/bin/bash

# Arguments
# None

newestBackup=$(ls -t /home/backups | head -1)

dropbox_uploader.sh -f /etc/environment upload /home/backups/${newestBackup} ./ >> /var/log/cron.log
