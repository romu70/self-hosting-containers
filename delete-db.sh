#!/bin/bash

### FOR DEVELOPMENT PURPOSE ONLY
### Delete a database and its associated user account from the DB server

### Pre-condition: your mysql client package must be installed.

### Create a MySQL/MariaDB database for a given service.
# Inputs:
DB_SERVER_HOST=$1
DB_SERVER_PORT=$2
DB_SERVER_ROOT_PWD=$3
DB_NAME=$4
DB_USER=$5

mysql -h $DB_SERVER_HOST -P $DB_SERVER_PORT -u root -p$DB_SERVER_ROOT_PWD -e "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -h $DB_SERVER_HOST -P $DB_SERVER_PORT -u root -p$DB_SERVER_ROOT_PWD -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM $DB_USER;"
mysql -h $DB_SERVER_HOST -P $DB_SERVER_PORT -u root -p$DB_SERVER_ROOT_PWD -e "DROP USER $DB_USER;"
mysql -h $DB_SERVER_HOST -P $DB_SERVER_PORT -u root -p$DB_SERVER_ROOT_PWD -e "FLUSH PRIVILEGES;"
