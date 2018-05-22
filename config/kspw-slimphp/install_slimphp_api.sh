#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git /home/api.kellenschmidt.com
cd /home/api.kellenschmidt.com

if [ "$1" == "dev" ]; then
	git checkout -b dev origin/dev
elif [ "$1" == "test" ]; then
	git checkout -b staging origin/staging
fi

sh install_composer.sh
php composer.phar install

shopt -s dotglob				# Enables moving dotfiles
mv /home/api.kellenschmidt.com/* /var/www
mv /var/www/public/* /var/www/html
rm -r /home/api.kellenschmidt.com /var/www/public
