# [Miniflux](https://www.miniflux.net/)

Docker setup to run Miniflux and store data in a external MySQL/MariaDB database. This image installs the latest Miniflux and the available themes. It must be built using the following arguments:
* DB_HOST to provide the database host
* DB_DATABASE to set the name of the database
* DB_USER to provide the database user account
* DB_PASSWORD...the password of the user.

Those arguments will modify the Miniflux' config.php file. 
