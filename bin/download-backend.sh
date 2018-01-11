#!/bin/sh

cd ../
git clone https://github.com/kellenschmidt/api.kellenschmidt.com.git
cd api.kellenschmidt.com
sh ../bin/install_composer.sh
php composer.phar install