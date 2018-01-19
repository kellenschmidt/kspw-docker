#!/usr/bin/env bash
docker-compose -f $1 stop
docker rm kspw-web kspw-db kspw-pma
rm -r database/data