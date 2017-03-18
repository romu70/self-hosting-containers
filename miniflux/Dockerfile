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
RUN apt-get install -yq nginx php7.0-fpm php7.0-common \
    php7.0-xml php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-mcrypt php7.0-mbstring\
    php7.0-json php7.0-curl supervisor mysql-client sudo git wget unzip cron
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

# ------------------------------------------------------------------------------
# Configure nginx
RUN mkdir -p /var/www
RUN chown www-data:www-data /var/www
RUN rm /etc/nginx/sites-enabled/*
RUN rm /etc/nginx/sites-available/*
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD conf/miniflux /etc/nginx/sites-enabled/

# ------------------------------------------------------------------------------
# Configure services
RUN update-rc.d nginx defaults
RUN update-rc.d php7.0-fpm defaults

# ------------------------------------------------------------------------------
# Install Miniflux
RUN mkdir -p /var/www/p
ENV VERSION 1.2.2
RUN wget https://github.com/miniflux/miniflux/archive/v${VERSION}.zip
RUN unzip v${VERSION}.zip
RUN mv miniflux-${VERSION}/* /var/www/p
RUN mv /var/www/p/config.default.php /var/www/p/config.default.php_
ADD conf/config.php /var/www/p/
ADD conf/db-setup.sh /var/www/p/
RUN chmod +x /var/www/p/db-setup.sh
RUN chown -R www-data:www-data /var/www/p/

# ------------------------------------------------------------------------------
# Install Miniflux Themes
# installing themes
WORKDIR /var/www/p/themes
RUN git clone https://github.com/miniflux/theme-bootstrap-light.git \
  && git clone https://github.com/miniflux/theme-bootswatch-cyborg.git \
  && git clone https://github.com/miniflux/theme-cards.git \
  && git clone https://github.com/miniflux/theme-nostyle.git \
  && git clone https://github.com/miniflux/theme-still.git \
  && git clone https://github.com/miniflux/theme-green.git \
  && git clone https://github.com/miniflux/theme-midnight.git \
  && git clone https://github.com/miniflux/theme-copper.git \
  && git clone https://github.com/meradoou/hello.git \
  && git clone -b flat https://github.com/meradoou/hello.git hello-flat \
  && git clone https://github.com/Cygnusfear/Miniflux-Theme-Sun.git \
  && rm -rf *.md *.pot */*/.empty */.empty .gitignore

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/p

# ------------------------------------------------------------------------------
# Setup the CRON job
RUN (crontab -l; echo "0 */4 * * *  cd /var/www/p && php cronjob.php >/dev/null 2>&1") | crontab -

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD conf/startup.conf /etc/supervisor/conf.d/

# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

