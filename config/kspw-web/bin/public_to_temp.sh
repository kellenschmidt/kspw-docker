#!/bin/bash

# Arguments
# None

mv /var/www/kellenschmidt.com/public /var/www/kellenschmidt.com/public_temp
mv /var/www/api.kellenschmidt.com/public /var/www/api.kellenschmidt.com/public_temp
mv /var/www/urlshortenerphp.kellenschmidt.com/public /var/www/urlshortenerphp.kellenschmidt.com/public_temp
mv /var/www/test.kellenschmidt.com/public /var/www/test.kellenschmidt.com/public_temp
mv /var/www/testapi.kellenschmidt.com/public /var/www/testapi.kellenschmidt.com/public_temp

mkdir /var/www/kellenschmidt.com/public \
      /var/www/api.kellenschmidt.com/public \
      /var/www/urlshortenerphp.kellenschmidt.com/public \
      /var/www/test.kellenschmidt.com/public \
      /var/www/testapi.kellenschmidt.com/public
