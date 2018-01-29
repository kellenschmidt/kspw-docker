#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

docker-compose -f $1 up -d --build --force-recreate
