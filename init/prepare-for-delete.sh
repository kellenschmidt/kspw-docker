#!/bin/bash

# Arguments
# None

rm ~/init/mysql-prod-*_*.sql.gz ~/init/*.sql

backupFile="~/kspw-docker/config/kspw-cron/db-backups/mysql-prod-*_*.sql.gz"
newestBackup=$(ls -t ${backupFile} | head -1)

if [ -f "$newestBackup" ]; then
  cp ${newestBackup} ~/init
  echo "Copying newest backup (${newestBackup}) from kspw-docker/ into init/"
elif [ -f "~/kspw-docker/config/kspw-db/database/schema-with-data/*.sql"]; then
  cp ~/kspw-docker/config/kspw-db/database/schema-with-data/*.sql ~/init
  echo "Copying database sql files from kspw-docker/ into init/"
else
  echo "No init files found in kspw-docker"
fi


