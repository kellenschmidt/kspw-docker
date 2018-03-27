#!/bin/bash

# Arguments
# None

rm ~/init/mysql-prod-*_*.sql.gz ~/init/*.sql

backupFileSqlGz=~/kspw-docker/config/kspw-db/database/schema-with-data/*.sql
newestBackupSqlGz=$(ls -t ${backupFileSqlGz} | head -1)

backupSql=~/init/*.sql
newestBackupSql=$(ls -t ${backupSql} | head -1)

if [ -f "$newestBackupSqlGz" ]; then
  cp ${newestBackupSqlGz} ~/init
  echo "Copying newest backup (${newestBackupSqlGz}) from kspw-docker/ into init/"
  ls -la ~/init
elif [ -f "$newestBackupSql" ]; then
  cp ~/kspw-docker/config/kspw-db/database/schema-with-data/*.sql ~/init
  echo "Copying database sql files from kspw-docker/ into init/"
  ls -la ~/init
else
  echo "No init files found in kspw-docker"
fi


