# docker build --build-arg ENVIRONMENT=dev -t kellenschmidt/kspw-slimphp:v_ .
# docker run --env-file ~kspw-k8s/kspw-slimphp.env -p 80:80 -d kellenschmidt/kspw-slimphp:v_

FROM php:7-apache

ARG ENVIRONMENT

RUN apt-get update -y && apt-get install -y git wget zip unzip && apt-get autoclean && \
    docker-php-ext-install pdo pdo_mysql mysqli

ADD install_slimphp_api.sh /home

RUN bash /home/install_slimphp_api.sh ${ENVIRONMENT}

# Set default ServerName (to remove warning)
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite && \
    service apache2 restart
