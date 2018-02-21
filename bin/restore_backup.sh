#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

backupFile="config/kspw-db/database/backups/mysql-$1-*_*.sql.gz"
newestBackup=$(ls -t ${backupFile} | head -1)

# Make directory for active sql files but also make empty directories
mkdir config/kspw-db/database/initialize config/kspw-db/database/backups config/kspw-db/database/schema-with-data
cp config/kspw-db/database/permissions/* config/kspw-db/database/initialize

# If a valid backup file exists
if [ -f "$newestBackup" ]; then
  # Restore the newest backup
  cp ${newestBackup} config/kspw-db/database/initialize
  echo "Restoring from backup"

# Elif the schema-with-data directory has contents
elif [ "$(ls -A config/kspw-db/database/schema-with-data)" ]; then
  cp config/kspw-db/database/schema-with-data/* config/kspw-db/database/initialize
  echo "Restoring from schema-with-data"

# Else copy schema without data to mysql init directory
else
  cp config/kspw-db/database/schema-only/* config/kspw-db/database/initialize
  echo "Restoring from schema-only"
fi
