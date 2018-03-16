FROM php:7-apache

ARG ENVIRONMENT

RUN apt-get update -y && apt-get install -y git wget cron nano gnupg zip unzip

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN mkdir /var/log/apache2/kellenschmidt.com && \
    mkdir /var/log/apache2/api.kellenschmidt.com/ && \
    mkdir /var/log/apache2/urlshortenerphp.kellenschmidt.com && \
    mkdir /var/log/apache2/test.kellenschmidt.com && \
    mkdir /var/log/apache2/testapi.kellenschmidt.com && \
    chmod -R 755 /var/www/ && \
    mkdir /home/bin && \
    mkdir /home/cron

ADD ./bin /home/bin

RUN bash /home/bin/install_kellenschmidt.com.sh ${ENVIRONMENT}
RUN bash /home/bin/install_api.kellenschmidt.com.sh ${ENVIRONMENT}
RUN bash /home/bin/install_urlshortenerphp.kellenschmidt.com.sh ${ENVIRONMENT}
RUN bash /home/bin/install_test.kellenschmidt.com.sh ${ENVIRONMENT}
RUN bash /home/bin/install_testapi.kellenschmidt.com.sh ${ENVIRONMENT}

ADD ./sites-available /etc/apache2/sites-available

# Set default ServerName (to remove warning)
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite
RUN a2ensite kellenschmidt.com && \
    a2ensite api.kellenschmidt.com && \
    a2ensite urlshortenerphp.kellenschmidt.com && \
    a2ensite test.kellenschmidt.com && \
    a2ensite testapi.kellenschmidt.com
RUN service apache2 restart
