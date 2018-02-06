FROM php:7-apache

RUN apt-get update -y && apt-get install -y git nodejs mysql-client wget cron nano

RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN a2enmod rewrite
ADD ./sites-available /etc/apache2/sites-available

RUN \
# kellenschmidt.com
    mkdir /var/www/kellenschmidt.com/ && \
    mkdir /var/www/kellenschmidt.com/public && \
    mkdir /var/log/apache2/kellenschmidt.com && \
# api.kellenschmidt.com
    mkdir /var/www/api.kellenschmidt.com && \
    mkdir /var/www/api.kellenschmidt.com/public && \
    mkdir /var/log/apache2/api.kellenschmidt.com/ && \
# urlshortenerphp.kellenschmidt.com
    mkdir /var/www/urlshortenerphp.kellenschmidt.com && \
    mkdir /var/www/urlshortenerphp.kellenschmidt.com/public && \
    mkdir /var/log/apache2/urlshortenerphp.kellenschmidt.com && \
# test.kellenschmidt.com
    mkdir /var/www/test.kellenschmidt.com && \
    mkdir /var/www/test.kellenschmidt.com/public && \
    mkdir /var/log/apache2/test.kellenschmidt.com && \
# testapi.kellenschmidt.com
    mkdir /var/www/testapi.kellenschmidt.com && \
    mkdir /var/www/testapi.kellenschmidt.com/public && \
    mkdir /var/log/apache2/testapi.kellenschmidt.com && \
# certbot
    mkdir /var/www/html/.well-known && \
    mkdir /var/www/html/.well-known/acme-challenge && \
# other
    chmod -R 755 /var/www/ && \
    mkdir /home/bin

ADD ./bin /home/bin

# Run certbot conditionally based on environment 
RUN bash -c "if [$ENV -eq \"prod\"]; \
    then bash /home/bin/run_certbot.sh kellenschmidt.com,api.kellenschmidt.com,urlshortenerphp.kellenschmidt.com; \
elif [$ENV -eq \"test\"]; \
    then bash /home/bin/run_certbot.sh test.kellenschmidt.com,testapi.kellenschmidt.com; \
fi"

RUN a2ensite kellenschmidt.com && \
    a2ensite api.kellenschmidt.com && \
    a2ensite urlshortenerphp.kellenschmidt.com && \
    a2ensite test.kellenschmidt.com && \
    a2ensite testapi.kellenschmidt.com
RUN service apache2 restart

# Add Cron commands to crontab
ADD ./cron /etc/cron.d
RUN crontab /etc/cron.d/renew-certs.cron
