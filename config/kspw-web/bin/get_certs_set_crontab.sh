#!/bin/bash

# Arguments
# None

wget https://dl.eff.org/certbot-auto -P /usr/bin
chmod a+x /usr/bin/certbot-auto
certbot-auto --non-interactive --agree-tos --email kellenschmidt31@gmail.com --authenticator webroot -w /var/www/html --installer apache --domains kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com,test.kellenschmidt.com,testapi.kellenschmidt.com

crontab /etc/cron.d/renew-certs.cron
