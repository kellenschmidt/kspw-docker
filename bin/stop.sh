#!/usr/bin/env bash

docker exec kspw-db bash /home/backup_db.sh | gzip -9 > database/backups/mysql_backup.sql.gz

docker-compose -f $1 stop
docker rm kspw-web kspw-db kspw-pma
rm -r database/data
