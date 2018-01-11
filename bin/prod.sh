#!/usr/bin/env bash
sudo docker-compose -f $1 stop
sudo docker-compose -f $1 build
sudo docker-compose -f $1 up -d
