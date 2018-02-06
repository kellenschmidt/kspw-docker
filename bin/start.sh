#!/bin/bash

# Arguments
# $1: File path to Docker compose file relative to root package.json

docker-compose -f $1 up -d --build --force-recreate

# Start cron
docker exec kspw-db cron
docker exec kspw-web cron
