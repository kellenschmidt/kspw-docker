#!/bin/bash

# Arguments
# None

rm -rf /var/www/kellenschmidt.com/public \
       /var/www/api.kellenschmidt.com/public \
       /var/www/urlshortenerphp.kellenschmidt.com/public \
       /var/www/test.kellenschmidt.com/public \
       /var/www/testapi.kellenschmidt.com/public

mv /var/www/kellenschmidt.com/public_temp /var/www/kellenschmidt.com/public
mv /var/www/api.kellenschmidt.com/public_temp /var/www/api.kellenschmidt.com/public
mv /var/www/urlshortenerphp.kellenschmidt.com/public_temp /var/www/urlshortenerphp.kellenschmidt.com/public
mv /var/www/test.kellenschmidt.com/public_temp /var/www/test.kellenschmidt.com/public
mv /var/www/testapi.kellenschmidt.com/public_temp /var/www/testapi.kellenschmidt.com/public
