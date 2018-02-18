#!/bin/bash

# Arguments
# None

backupFile="/home/backups/mysql-${ENV}-*_*.sql.gz"
newestBackup=$(ls -t ${backupFile} | head -1)

mkdir /home/sql
echo "Start restore. backupFile: ${backupFile}, newestBackup: ${newestBackup}" > /var/log/restore.log

# If a valid backup file exists
if [ -f "$newestBackup" ]; then
    # Restore the newest backup
    gzip -dk < ${newestBackup} > /home/sql/${newestBackup:14:-3}
    echo "Restoring from backup" >> /var/log/restore.log
# Elif the schema-with-data directory has contents
elif [ "$(ls -A /home/schema-with-data)" ]; then
    cp /home/schema-with-data/* /home/sql
    echo "Restoring from schema-with-data" >> /var/log/restore.log
# Else copy schema without data to mysql init directory
else
    cp /home/schema-only/* /home/sql
    echo "Restoring from schema-only" >> /var/log/restore.log
fi

echo "End restore" >> /var/log/restore.log

cat /home/sql/*.sql > /home/combined.sql
cat /home/permissions/grant_permissions.sql >> /home/combined.sql
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD < /home/combined.sql
