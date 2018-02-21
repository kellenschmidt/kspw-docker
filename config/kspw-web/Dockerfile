FROM php:7-apache

RUN apt-get update -y && apt-get install -y git nodejs mysql-client wget cron nano

RUN docker-php-ext-install pdo pdo_mysql mysqli

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
# other
    chmod -R 755 /var/www/ && \
    mkdir /home/bin

ADD ./sites-available /etc/apache2/sites-available
ADD ./cron /etc/cron.d

# Set default ServerName (to remove warning)
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite
RUN a2ensite kellenschmidt.com && \
    a2ensite api.kellenschmidt.com && \
    a2ensite urlshortenerphp.kellenschmidt.com && \
    a2ensite test.kellenschmidt.com && \
    a2ensite testapi.kellenschmidt.com
RUN service apache2 restart
