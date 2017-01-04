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
RUN apt-get install -yq nginx fontconfig-config fonts-dejavu-core php7.0-curl\
    php7.0-fpm php7.0-common php7.0-json php7.0-cli php7.0-common php7.0-mysql\
    php7.0-gd php7.0-json php7.0-mcrypt php7.0-readline php7.0-intl php7.0-xml php-apcu\
    php7.0-mbstring psmisc libgd-tools libmcrypt-dev mcrypt mysql-client supervisor sudo git

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
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD conf/ttrss /etc/nginx/sites-enabled/

# ------------------------------------------------------------------------------
# Configure services
RUN update-rc.d nginx defaults
RUN update-rc.d php7.0-fpm defaults

# ------------------------------------------------------------------------------
# Install Tiny Tiny RSS
RUN git clone --depth 1 https://tt-rss.org/gitlab/fox/tt-rss.git && \
    rm -rf *.md *.pot */*/.empty */.empty .gitignore utils
RUN mv tt-rss/* /var/www

# ------------------------------------------------------------------------------
# Install Wallabag v2 plugin: https://github.com/joshp23/ttrss-to-wallabag-v2
RUN git clone --depth 1 https://github.com/joshp23/ttrss-to-wallabag-v2
RUN mv ttrss-to-wallabag-v2/wallabag_v2 /var/www/plugins.local/

# ------------------------------------------------------------------------------
# Install https://github.com/naeramarth7/clean-greader
RUN git clone --depth 1 https://github.com/naeramarth7/clean-greader
RUN mv clean-greader /var/www/themes/
RUN cp /var/www/themes/clean-greader/clean-greader.css /var/www/themes/

# ------------------------------------------------------------------------------
# Install https://github.com/levito/tt-rss-feedly-theme
RUN git clone --depth 1 https://github.com/levito/tt-rss-feedly-theme
RUN mv tt-rss-feedly-theme/feedly /var/www/themes/
RUN mv tt-rss-feedly-theme/feedly.css /var/www/themes/

# ------------------------------------------------------------------------------
# Set proper access rights
RUN chmod 777 -R /var/www/cache /var/www/feed-icons /var/www/lock

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Add supervisord conf
ADD conf/startup.conf /etc/supervisor/conf.d/

# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

