#!/bin/bash

### Setup the Miniflux data back end

# Inputs:
DB_DRIVER=$1
DB_HOST=$2
DB_PORT=$3
DB_NAME=$4
DB_USER=$5
DB_USER_PWD=$6

sed -i -e "s/db-driver\s*/$DB_DRIVER/g" /var/www/config.php\
sed -i -e "s/db-host\s*/$DB_HOST/g" /var/www/config.php\
sed -i -e "s/db-port\s*/$DB_PORT/g" /var/www/config.php\
sed -i -e "s/db-name\s*/$DB_DATABASE/g" /var/www/config.php\
sed -i -e "s/db-user\s*/$DB_USER/g" /var/www/config.php\
sed -i -e "s/db-password\s*/$DB_PASSWORD/g" /var/www/config.php
