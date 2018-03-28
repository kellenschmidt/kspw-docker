#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

echo "ENV=$1" >> .env

if [ "$1" == "prod" ]; then
  docker system prune -af
fi

# Load database
bash bin/restore_backup.sh $1

# Start Docker
docker-compose -f config/docker-compose.yml build --no-cache 
docker-compose -f config/docker-compose.yml up -d --build --force-recreate 

# Doesn't work when executed at end of Dockerfile
docker exec kspw-web bash /home/bin/get_certs_set_crontab.sh $1
