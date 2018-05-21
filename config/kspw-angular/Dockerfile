# docker build --build-arg ENVIRONMENT=dev -t kellenschmidt/kspw-angular:v_ .
# docker run -p 80:80 -d kellenschmidt/kspw-angular:v_

FROM node:9-alpine

ARG ENVIRONMENT

RUN apk update && apk add --no-cache git apache2

ADD ./apache-confs/httpd.conf /etc/apache2
ADD ./apache-confs/kellenschmidt.com.conf /etc/apache2/conf.d
ADD ./apache-confs/test.kellenschmidt.com.conf /etc/apache2/conf.d

RUN mkdir /var/log/apache2/kellenschmidt.com && \
  mkdir /var/log/apache2/test.kellenschmidt.com && \
  chmod -R 755 /var/www/ && \
  mkdir /run/apache2

ADD install_kellenschmidt.com.sh /home
RUN sh /home/install_kellenschmidt.com.sh ${ENVIRONMENT}

CMD ["/usr/sbin/httpd", "-DFOREGROUND", "-f", "/etc/apache2/httpd.conf"]
