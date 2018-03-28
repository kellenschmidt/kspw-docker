#!/bin/bash

# Arguments
# None

if [ ! -d ~/init ]; then
  cp -r ~/kspw-docker/init ~/init
  echo "Copying init folder from kspw-docker/ to ~/"
fi

rm ~/init/mysql-prod-*_*.sql.gz ~/init/*.sql

backupFileSqlGz=~/kspw-docker/config/kspw-db/schema-with-data/*.sql
newestBackupSqlGz=$(ls -t ${backupFileSqlGz} | head -1)

backupSql=~/init/*.sql
newestBackupSql=$(ls -t ${backupSql} | head -1)

if [ -f "$newestBackupSqlGz" ]; then
  cp ${newestBackupSqlGz} ~/init
  echo "Copying newest backup (${newestBackupSqlGz}) from kspw-docker/ into init/"

elif [ -f "$newestBackupSql" ]; then
  cp ~/kspw-docker/config/kspw-db/schema-with-data/*.sql ~/init
  echo "Copying database sql files from kspw-docker/ into init/"

else
  echo "No init files found in kspw-docker"
fi

cp ~/kspw-docker/.env ~/init
ls -la ~/init
