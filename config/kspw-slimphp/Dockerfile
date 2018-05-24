# docker build --build-arg ENVIRONMENT=dev -t kellenschmidt/kspw-slimphp .
# docker run --env-file ./kspw-slimphp.env -p 80:80 -d kellenschmidt/kspw-slimphp

FROM php:7-apache

ARG ENVIRONMENT

RUN apt-get update -y && apt-get install -y git wget zip unzip nano && apt-get autoclean && \
    docker-php-ext-install pdo pdo_mysql mysqli

ADD install_slimphp_api.sh /home
ADD apache2.conf /etc/apache2

RUN bash /home/install_slimphp_api.sh ${ENVIRONMENT}

RUN a2enmod rewrite && \
    service apache2 restart
