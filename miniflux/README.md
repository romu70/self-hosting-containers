# [Miniflux](https://www.miniflux.net/)

Docker setup to run Miniflux. This image installs the latest Miniflux and the available themes. Once built, open a terminal within the container with the following command:
```docker exec -t -i miniflux /bin/bash```, go to the ```/var/www/p``` folder and run the DB init script: ```./db-setup.sh db-driver db-host db-port db-name db-user db-password```.


