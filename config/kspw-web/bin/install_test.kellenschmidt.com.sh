#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

mkdir /var/www/test.kellenschmidt.com
if [ "$1" == "test" ]; then
  git clone https://github.com/kellenschmidt/kellenschmidt.com.git /var/www/test.kellenschmidt.com
  cd /var/www/test.kellenschmidt.com
	git checkout -b dev origin/staging
  yarn install
  node --max-old-space-size=1024 ./node_modules/.bin/ng build --prod --env=$1
else
  mkdir /var/www/test.kellenschmidt.com/public
fi
