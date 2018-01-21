#!/bin/sh

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
    git checkout -b docker-dev origin/docker-dev
fi
sh install_composer.sh
php composer.phar install
