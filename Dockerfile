# Docker php54
#
# veresion 1.2

FROM aooj/base:latest

MAINTAINER AooJ "aooj@n13.cz"

RUN add-apt-repository -y ppa:nginx/stable
RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN apt-get update

RUN apt-get -y install  nginx php5-fpm php5-mysql php-apc php5-cli php5-cgi php-pear php5-imagick php5-imap php5-mcrypt php5-gd git-core php5-curl && apt-get clean

ADD files/nginx/default /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir -p /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php


# configure
RUN sed -i '0,/worker_processes [0-9]*;/s//worker_processes 1;/' /etc/nginx/nginx.conf
RUN sed -i '0,/worker_connections [0-9]*;/s//worker_connections 50;/' /etc/nginx/nginx.conf

#php fpm
ADD files/php5 /etc/php5
RUN mkdir -p /var/log/php
RUN touch /var/log/php/www.access.log
RUN touch /var/log/php/www.slow.log
ADD files/supervisor/ /etc/supervisor/conf.d/

#nginx ssl
ADD files/create-ssl.sh /tmp/create-ssl.sh
RUN chmod +x /tmp/create-ssl.sh && /tmp/create-ssl.sh && rm /tmp/create-ssl.sh


EXPOSE 80 443
