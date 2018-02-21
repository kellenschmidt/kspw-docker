#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

if [ "$1" == "test" ]; then
  git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git /var/www/testapi.kellenschmidt.com
  cd /var/www/testapi.kellenschmidt.com
	git checkout -b dev origin/staging
  sh install_composer.sh
  php composer.phar install
fi
