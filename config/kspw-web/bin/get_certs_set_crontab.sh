#!/bin/bash

# Arguments
# $1: Name of environment that is being deployed

if [ "$1" != "docker" ]; then
  wget https://dl.eff.org/certbot-auto -P /usr/bin
  chmod a+x /usr/bin/certbot-auto

  bash /home/bin/public_to_temp.sh

  certbot-auto --non-interactive --agree-tos --redirect --apache --email kellenschmidt31@gmail.com --domains kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com,test.kellenschmidt.com,testapi.kellenschmidt.com > /var/log/certs.log

  bash /home/bin/temp_to_public.sh

  crontab /home/cron/renew-certs.cron

  service cron start
fi
