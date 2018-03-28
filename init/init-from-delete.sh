#!/bin/bash

# Arguments
# None

if [ ! -d ~/init ]; then
  cp -r ~/kspw-docker/init ~/init
  echo "Copying init folder from kspw-docker/ to ~/"
fi

backupSqlGz=~/init/mysql-prod-*_*.sql.gz
newestBackupSqlGz=$(ls -t ${backupSqlGz} | head -1)

backupSql=~/init/*.sql
newestBackupSql=$(ls -t ${backupSql} | head -1)

if [ -f "$newestBackupSqlGz" ]; then
  # Restore the newest backup
  mkdir ~/kspw-docker/config/kspw-cron/db-backups
  cp ${newestBackupSqlGz} ~/kspw-docker/config/kspw-cron/db-backups
  echo "Copying newest backup (${newestBackupSqlGz}) from init/ into kspw-docker/"
  ls -la ~/kspw-docker/config/kspw-cron/db-backups

elif [ -f "$newestBackupSql" ]; then
  # Restore from sql file(s)
  mkdir ~/kspw-docker/config/kspw-db/schema-with-data/
  cp ~/init/*.sql ~/kspw-docker/config/kspw-db/schema-with-data
  echo "Copying database sql files from init/ into kspw-docker/"
  ls -la ~/kspw-docker/config/kspw-db/schema-with-data

else
  echo "No init files provided"
fi

cp ~/init/.env ~/kspw-docker
ls -la ~/kspw-docker
