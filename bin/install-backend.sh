#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

if [ "$1" == "test" ]
then
	folder="testapi.kellenschmidt.com"
else
	folder="api.kellenschmidt.com"
fi

rm -rf $folder
git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git $folder
cd $folder
if [ "$1" != "prod" ]; then
    git checkout -b dev origin/dev
fi
sh install_composer.sh
php composer.phar install

echo "ENV=$1" >> ../.env
