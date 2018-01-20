#!/bin/sh

rm -rf api.kellenschmidt.com
git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git
cd api.kellenschmidt.com
git checkout -b docker-dev origin/docker-dev
sh install_composer.sh
php composer.phar install