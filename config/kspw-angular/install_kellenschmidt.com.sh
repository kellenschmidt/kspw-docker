#!/bin/sh

# Arguments
# $1: Name of environment that is being deployed

mkdir /var/www/kellenschmidt.com
git clone https://github.com/kellenschmidt/kellenschmidt.com.git /var/www/kellenschmidt.com
cd /var/www/kellenschmidt.com

if [ "$1" == "dev" ]; then
	git checkout -b dev origin/dev
	rm /etc/apache2/conf.d/test.kellenschmidt.com.conf
elif [ "$1" == "test" ]; then
	git checkout -b staging origin/staging
	rm /etc/apache2/conf.d/kellenschmidt.com.conf
else
	rm /etc/apache2/conf.d/test.kellenschmidt.com.conf
fi

yarn install
./node_modules/.bin/ng build --prod --env=$1
