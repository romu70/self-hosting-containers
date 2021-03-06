#!/bin/bash

### Setup the Leanote data back end

# Inputs:
DB_HOST=$1
DB_PORT=$2
DB_USER=$3
DB_USER_PWD=$4
APP_SECRET=$5
HOST_ADDR=$6
HOST_PORT=$7

sed -i -e "s/db-host\s*/$DB_HOST/g" ./app.conf
sed -i -e "s/db-port\s*/$DB_PORT/g" ./app.conf
sed -i -e "s/db-user\s*/$DB_USER/g" ./app.conf
sed -i -e "s/db-pwd\s*/$DB_USER_PWD/g" ./app.conf
sed -i -e "s/host-addr\s*/$HOST_ADDR/g" ./app.conf
sed -i -e "s/host-port\s*/$HOST_PORT/g" ./app.conf

