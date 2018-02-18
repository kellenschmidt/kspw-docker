#!/bin/bash

# Arguments
# $1: File path to Docker compose file relative to root package.json

docker-compose -f $1 up -d --build --force-recreate

# Load database
docker exec kspw-db bash /home/bin/restore_backup.sh

# Start cron
docker exec kspw-db cron
docker exec kspw-web cron
