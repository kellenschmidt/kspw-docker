#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

# Load database
bash bin/restore_backup.sh $1

# Start Docker
docker-compose -f config/docker-compose.yml up -d --build --force-recreate

# Start cron inside Docker
docker exec kspw-db cron
docker exec kspw-web cron
