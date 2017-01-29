#!/bin/bash

### Setup the Miniflux MySQL/MariaDB data back end

# Inputs:
DB_HOST=$1
DB_PORT=$2
DB_NAME=$3
DB_USER=$4
DB_USER_PWD=$5

sed -i -e "s/db-host\s*/$DB_HOST/g" ./config.php
sed -i -e "s/db-port\s*/$DB_PORT/g" ./config.php
sed -i -e "s/db-name\s*/$DB_NAME/g" ./config.php
sed -i -e "s/db-user\s*/$DB_USER/g" ./config.php
sed -i -e "s/db-password\s*/$DB_USER_PWD/g" ./config.php
