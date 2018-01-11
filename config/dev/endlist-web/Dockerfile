FROM php:7-apache

RUN apt-get update -y && apt-get install -y libpng-dev curl git libcurl4-openssl-dev nodejs

RUN docker-php-ext-install pdo pdo_mysql gd curl

RUN a2enmod rewrite
# RUN a2enmod headers
RUN service apache2 restart
