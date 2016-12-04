# ------------------------------------------------------------------------------
# Based on a work at https://github.com/docker/docker.
# ------------------------------------------------------------------------------
# Pull base image.
FROM ubuntu:16.04
MAINTAINER R. Tisserand <r@tisserand.eu>

# ------------------------------------------------------------------------------
# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN echo "Europe/Paris" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# ------------------------------------------------------------------------------
# Install Base
# Add ppa for PHP, ubuntu 16.04 has php7 yeah :)
#RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list
#RUN echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN apt-get update -qq
RUN apt-get install debconf-utils
#RUN debconf-get-selections | grep mysql
RUN apt-get install -yq wget unzip nginx fontconfig-config fonts-dejavu-core \
    php7.0-fpm php7.0-common php7.0-json php7.0-cli php7.0-common php7.0-mysql\
    php7.0-gd php7.0-json php7.0-mcrypt php7.0-readline php7.0-intl php7.0-xml php-apcu\
    psmisc ssl-cert ufw libgd-tools libmcrypt-dev mcrypt mysql-client supervisor sudo

# ------------------------------------------------------------------------------
# Configure Supervisor
RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# ------------------------------------------------------------------------------
# Configure php-fpm
RUN sed -i -e "s/output_buffering\s*=\s*4096/output_buffering = Off/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 1G/g" /etc/php/7.0/fpm/php.ini
RUN mkdir -p /var/run/
RUN sed -i -e "s|pid = .*$|pid = /var/run/php7.0-fpm.pid|" /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i -e "s|listen = .*$|listen = /var/run/php7.0-fpm.sock|" /etc/php/7.0/fpm/pool.d/www.conf

# ------------------------------------------------------------------------------
# Configure nginx
RUN mkdir -p /var/www
RUN chown www-data:www-data /var/www
RUN rm /etc/nginx/sites-enabled/*
RUN rm /etc/nginx/sites-available/*
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD conf/pydio /etc/nginx/sites-enabled/
#RUN mkdir -p /etc/nginx/ssl
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj '/CN=localhost/O=My Company Name LTD./C=US'

# ------------------------------------------------------------------------------
# Install & Configure ioncube
WORKDIR /tmp
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip
# TODO checksum check
RUN unzip ioncube_loaders_lin_x86-64.zip
RUN mv ioncube/ioncube_loader_lin_7.0.so /usr/lib/php/20151012
RUN echo "zend_extension=/usr/lib/php/20151012/ioncube_loader_lin_7.0.so" > /etc/php/7.0/fpm/conf.d/00-ioncube.ini
RUN echo "zend_extension=/usr/lib/php/20151012/ioncube_loader_lin_7.0.so" > /etc/php/7.0/cli/conf.d/00-ioncube.ini

# ------------------------------------------------------------------------------
# Configure services
RUN update-rc.d nginx defaults
RUN update-rc.d php7.0-fpm defaults

# ------------------------------------------------------------------------------
# Install Pydio
ENV PYDIO_VERSION 7.0.2
#ENV WORKDIR /var/www

RUN wget https://download.pydio.com/pub/core/archives/pydio-core-${PYDIO_VERSION}.zip
RUN unzip pydio-core-${PYDIO_VERSION}.zip
RUN mv pydio-core-${PYDIO_VERSION} /var/www/pydio-core
RUN chown -R www-data:www-data /var/www/pydio-core
RUN chmod -R 770 /var/www/pydio-core
RUN chmod 777  /var/www/pydio-core/data/files/
RUN chmod 777  /var/www/pydio-core/data/personal/

WORKDIR /
RUN ln -s /var/www/pydio-core/data pydio-data

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
#EXPOSE 443
EXPOSE 8090

# ------------------------------------------------------------------------------
# Expose volumes
VOLUME /pydio-data/files
VOLUME /pydio-data/personal

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD conf/startup.conf /etc/supervisor/conf.d/

# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

