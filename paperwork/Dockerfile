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
RUN apt-get update -qq
RUN apt-get install debconf-utils
RUN apt-get install -yq php7.0-mysql git nginx php7.0-fpm curl wget git php7.0-cli\
            supervisor php7.0-gd php7.0-mcrypt nodejs npm php7.0-xml zip\
            unzip
RUN apt-get clean

# ------------------------------------------------------------------------------
# Configure Supervisor
RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# ------------------------------------------------------------------------------
# Configure php-fpm
RUN sed -i -e "s/output_buffering\s*=\s*4096/output_buffering = Off/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.0/fpm/php.ini
RUN mkdir -p /var/run/
RUN sed -i -e "s|pid = .*$|pid = /var/run/php7.0-fpm.pid|" /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i -e "s|listen = .*$|listen = /var/run/php7.0-fpm.sock|" /etc/php/7.0/fpm/pool.d/www.conf
RUN echo "extension=mcrypt.so" >> /etc/php/7.0/fpm/php.ini
RUN echo "extension=mcrypt.so" >> /etc/php/7.0/cli/php.ini

# ------------------------------------------------------------------------------
# Configure nginx
RUN mkdir -p /var/www
RUN chown www-data:www-data /var/www
RUN rm /etc/nginx/sites-enabled/*
RUN rm /etc/nginx/sites-available/*
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD conf/paperwork /etc/nginx/sites-enabled/

# ------------------------------------------------------------------------------
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# ------------------------------------------------------------------------------
# Install Paperwork
WORKDIR /var/www
RUN git clone https://github.com/twostairs/paperwork.git
WORKDIR /var/www/paperwork/frontend/
RUN composer install
#RUN mv ./app/storage/config/default_database.json ./app/storage/config/default_database.json.backup 
#ADD conf/default_database.json ./app/storage/config
#ADD conf/db-setup.sh /var/www/paperwork/frontend/
#RUN chmod +x /var/www/paperwork/frontend/db-setup.sh
RUN chown www-data:www-data -R /var/www/

# ------------------------------------------------------------------------------
# Install NPM
WORKDIR /var/www/paperwork/frontend/
#RUN wget https://www.npmjs.com/install.sh
#RUN bash ./install.sh
RUN npm install -g gulp bower
RUN npm install
RUN bower install --allow-root
RUN gulp

# ------------------------------------------------------------------------------
# Configure services
RUN update-rc.d nginx defaults
RUN update-rc.d php7.0-fpm defaults

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD conf/startup.conf /etc/supervisor/conf.d/

# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

