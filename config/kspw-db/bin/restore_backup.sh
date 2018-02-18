#!/bin/bash

# Arguments
# $1: Time period type of backup

backupFile="/home/backups/mysql-${ENV}-$1_*.sql.gz"
newestBackup=$(ls -t ${backupFile} | head -1)

# If a valid backup file exists
if [ -f $backupFile ]; then
    # Restore the newest backup
    gzip -dk < /home/backups/${newestBackup} > /docker-entrypoint-initdb.d/${newestBackup::-3}
# Elif the schema-with-data directory has contents
elif [ "$(ls -A /home/schema-with-data)" ]; then
    cp /home/schema-with-data /docker-entrypoint-initdb.d
# Else copy schema without data to mysql init directory
else
    cp /home/schema /docker-entrypoint-initdb.d
fi
