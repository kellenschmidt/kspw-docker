#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

mkdir /var/www/api.kellenschmidt.com
git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git /var/www/api.kellenschmidt.com
cd /var/www/api.kellenschmidt.com
if [ "$1" == "docker" ]; then
	git checkout -b dev origin/dev
fi
sh install_composer.sh
php composer.phar install
