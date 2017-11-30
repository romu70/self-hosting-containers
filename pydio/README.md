# [Pydio](https://www.pydio.com/) Deprecated

Image to install and run the community edition of Pydio, current version: 7.0.2.

## Build the image

Once you cloned this repository, open a terminal within the pydio folder and run:

```docker build -t pydio .```

Get a coffee!

## Create the named volumes

Named volumes will allow you to create a bridge between your host and the container, this way, you keep access to your files whatever happens with your container.

To create the *files* and *personal* volumes, run:

```docker volume create --name files```
```docker volume create --name personal```

If you want to know where Docker stores those folders, you can run:

```docker volume inspect personal```

## Run the container

First, you must create a database, and a good idea could be to use the *create-db.sh* at the root of this repository.

Then, you can run the container by running:

```docker run --name pydio -v files:/var/www/pydio-core/data/files -v personal:/var/www/pydio-core/data/personal -d -p PORT:80 pydio:latest```

PORT: the port to expose Pydio on your host

## Complete the Pydio setup

Open your web browser to: ```http://_your host address_:_port_``` and follow the instructions. Enjoy!
