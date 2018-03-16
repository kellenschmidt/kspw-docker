#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

echo "ENV=$1" >> .env

# Load database
bash bin/restore_backup.sh $1

# Start Docker
# docker-compose -f config/docker-compose.yml build --no-cache 
docker-compose -f config/docker-compose.yml up -d --build --force-recreate 
