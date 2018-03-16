#!/bin/bash

# Arguments
# None

docker exec kspw-cron /home/bin/backup_db.sh exit
docker exec kspw-cron /home/bin/remove_backups.sh exit
docker exec kspw-cron /home/bin/upload_cloud.sh

docker-compose -f config/docker-compose.yml stop
docker rm kspw-web \
          kspw-db \
          kspw-cron \
          kspw-pma

rm -r config/kspw-db/database/initialize
