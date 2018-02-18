#!/bin/bash

# Arguments
# None

docker exec kspw-db bash /home/bin/backup_db.sh exit
docker exec kspw-db bash /home/bin/remove_backups.sh exit
docker exec kspw-db bash /home/bin/upload_cloud.sh

docker-compose -f config/docker-compose.yml stop
docker rm kspw-web \
          kspw-db \
          kspw-pma

rm -r config/kspw-db/database/initialize
