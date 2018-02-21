#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

if [ "$1" == "test" ]
then
	folder="test.kellenschmidt.com"
else
	folder="kellenschmidt.com"
fi

rm -rf $folder
git clone https://github.com/kellenschmidt/kellenschmidt.com.git $folder
cd $folder
if [ "$1" != "prod" ]; then
	git checkout -b dev origin/dev
fi

npm install

# Build frontend
if [ "$1" != "docker" ]; then
	# Increase max memory usage of process for server
	node --max-old-space-size=768 ./node_modules/.bin/ng build --prod --env=$1
else
	# Normal build with regular memory size
	ng build --prod --env=$1
fi
