#!/bin/bash

### Setup the Paperwork data back end

# Inputs:
DB_HOST=$1
DB_PORT=$2
DB_USER_PWD=$3

sed -i -e "s/db-host\s*/$DB_HOST/g" ./database.json
sed -i -e "s/db-port\s*/$DB_PORT/g" ./database.json
sed -i -e "s/db-password\s*/$DB_USER_PWD/g" ./database.json

php artisan migrate
