#!/bin/bash

# Arguments
# None

if [ ! -d ~/init ]; then
  cp ~/kspw-docker/init ~/init
  echo "Copying init folder from kspw-docker/ to ~/"
fi

backupFile="~/init/mysql-prod-*_*.sql.gz"
newestBackup=$(ls -t ${backupFile} | head -1)

if [ -f "$newestBackup" ]; then
  # Restore the newest backup
  cp ${newestBackup} ~/kspw-docker/config/kspw-cron/db-backups
  echo "Copying newest backup (${newestBackup}) from init/ into kspw-docker/"
  ls -la ~/kspw-docker/config/kspw-cron/db-backups
elif [ -f "*.sql"]; then
  # Restore from sql file(s)
  cp *.sql ~/kspw-docker/config/kspw-db/schema-with-data
  echo "Copying database sql files from init/ into kspw-docker/"
  ls -la ~/kspw-docker/config/kspw-db/schema-with-data
else
  echo "No init files provided"
fi
