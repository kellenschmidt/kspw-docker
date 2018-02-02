#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

docker exec kspw-db bash /home/bin/backup_db.sh exit

docker-compose -f $1 stop
docker rm kspw-web \
          kspw-db \
          kspw-pma
rm -r database/data
