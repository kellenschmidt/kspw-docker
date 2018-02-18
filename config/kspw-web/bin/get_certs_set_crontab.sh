#!/bin/bash

# Arguments
# None

wget https://dl.eff.org/certbot-auto -P /usr/bin
chmod a+x /usr/bin/certbot-auto
certbot-auto --non-interactive --agree-tos --apache --email kellenschmidt31@gmail.com --domains kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com,test.kellenschmidt.com,testapi.kellenschmidt.com > /var/log/certs.log

crontab /etc/cron.d/renew-certs.cron
