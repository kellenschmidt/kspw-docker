#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

mkdir /var/www/kellenschmidt.com
git clone https://github.com/kellenschmidt/kellenschmidt.com.git /var/www/kellenschmidt.com
cd /var/www/kellenschmidt.com
if [ "$1" == "docker" ]; then
	git checkout -b dev origin/dev
fi
yarn install

if [ "$1" != "docker" ]; then
	# Increase max memory usage of process for server
	node --max-old-space-size=1024 ./node_modules/.bin/ng build --prod --env=$1
else
	# Normal build with regular memory size
	./node_modules/.bin/ng build --prod --env=$1
fi
