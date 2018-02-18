#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

# Load database
bash bin/restore_backup.sh $1

# Start Docker
docker-compose --no-cache -f config/docker-compose.yml build
docker-compose --build --force-recreate -f config/docker-compose.yml up

# Start cron inside Docker
docker exec kspw-db cron
docker exec kspw-web cron
