#!/usr/bin/env bash

docker-compose -f $1 up -d --build --force-recreate
