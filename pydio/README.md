# [Pydio](https://www.pydio.com/)

Image to install and run the community edition of Pydio, current version: 7.0.2.

## Build the image

Once you cloned this repository, open a terminal within the pydio folder and run:

```docker build -t pydio .```

Get a coffee!

## Run the container

First, you must create a database, and a good idea could be to use the *create-db.sh* at the root of this repository.

Then, you can run the container by running:

```docker run --name pydio -v @host files folder@:/var/www/pydio-core/data/files -v @host personal folder@:/var/www/pydio-core/data/personal -d -p @port@:80 pydio:latest```

@host files folder@ must be an absolute path of the location where common files will be stored

@host personal folder@ must be an absolute path of the location where personal files (per user account) will be stored

@port@: the port to expose Pydio on your host

But but but, this is not terminated. As time of writing, there is a small issue which prevents storage to work, it is related to access rights and folder ownership. Here are the instructions to fix it.

* Open a terminal inside your container

```docker exec -t -i pydio /bin/bash```

* Go to the Pydio data folder

```cd /var/www/pydio-core/data```

* Fix storages permissions

```chmod 770 -R files/ personal/```

* Fix ownership

```chown www-data:www-data -R files/ personal/```

## Complete the Pydio setup

Open your web browser to: ```http://_your host address_:_port_``` and follow the instructions. Enjoy!
