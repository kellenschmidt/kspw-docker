FROM php:7-apache

RUN apt-get update -y && apt-get install -y libpng-dev curl git libcurl4-openssl-dev nodejs

RUN docker-php-ext-install pdo pdo_mysql gd curl

RUN a2enmod rewrite
ADD ./sites-available /etc/apache2/sites-available
ADD ./www/index.html /var/www

RUN \
    mkdir /var/www/kellenschmidt.com/ && \
    mkdir /var/www/kellenschmidt.com/public && \
    # mkdir /var/log/apache2/kellenschmidt.com && \
    mkdir /var/www/api.kellenschmidt.com && \
    mkdir /var/www/api.kellenschmidt.com/public && \
    # mkdir /var/log/apache2/api.kellenschmidt.com/ && \
    chmod -R 755 /var/www/

# RUN a2dissite 000-default
    # a2ensite kellenschmidt.com && \
    # a2ensite api.kellenschmidt.com
RUN service apache2 restart
