#!/bin/bash

# Arguments
# None

if [ "$ENV" = "prod" ]
then
    bash /home/bin/run_certbot.sh kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com
    crontab /etc/cron.d/renew-certs.cron
elif [ "$ENV" = "test" ]
then
    bash /home/bin/run_certbot.sh test.kellenschmidt.com,testapi.kellenschmidt.com;
    crontab /etc/cron.d/renew-certs.cron
fi
