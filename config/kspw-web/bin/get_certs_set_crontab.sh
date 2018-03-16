#!/bin/bash

# Arguments
# None

wget https://dl.eff.org/certbot-auto -P /usr/bin
chmod a+x /usr/bin/certbot-auto

bash /home/bin/public_to_temp.sh

certbot-auto --non-interactive --agree-tos --apache --email kellenschmidt31@gmail.com --domains kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com,test.kellenschmidt.com,testapi.kellenschmidt.com > /var/log/certs.log

bash /home/bin/temp_to_public.sh

crontab /home/cron/renew-certs.cron
