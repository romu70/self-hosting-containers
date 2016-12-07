# Introduction

This repository contains stuff for self-hosting. Slef hosting of services is based on Docker containers, and I assume you have access to a MySQL/MariaDB database server (which can be a Docker container as well but in my case it's run by the physical server).

This repository doesn't deal with SSL, certificates etc. My own server already provides a nice GUI to setup SSL reverse proxy and Let's Encrypt certificates, but feel free security related stuff.

# Utilities

You can find 2 scripts (create-db.sh and delete-sb.sh) at the root of this repsitory. The first one is to create a couple database/user to store the data for a particular service, should be run before the container to initiate the data back end. The second script (delete-db.sh) should be used only for debug and development purposes, but also if you want to get rif off a service (and its data) for good, use it CAREFULLY.

# Services

Here is a list of services I run with addional notes.

## [Wallabag](https://www.wallabag.org/)

Use the official Docker image provided [here](https://hub.docker.com/r/wallabag/wallabag/), works great.

## [Pydio](https://www.pydio.com/)

Image to install and run the community edition of Pydio, current version: 7.0.2.

### Build the image ###

Once you cloned this repository, open a terminal within the pydio folder and run:

```docker build -t pydio .```

Get a coffee!

### Run the container ###

First, you must create a database, and a good idea could be to use the *create-db.sh* at the root of this repository.

Then, you can run the container by running:

```docker run --name pydio -v _host files folder_:/var/www/pydio-core/data/files -v _host personal folder_:/var/www/pydio-core/data/personal -d -p _port_:80 pydio:latest```

_host files folder_ must be an absolute path of the location where common files will be stored
_host personal folder_ must be an absolute path of the location where personal files (per user account) will be stored
_port_: the port to expose Pydio on your host

But but but, this is not terminated. As time of writing, there is a small issue which prevents storage to work, it is related to access rights and folder ownership. Here are the instructions to fix it.

1. Open a terminal inside your container

```docker exec -t -i pydio /bin/bash```

2. Go to the Pydio data folder

```cd /var/www/pydio-core/data```

3. Fix storages permissions

```chmod 770 -R files/ personal/```

4. Fix ownership

```chown www-data:www-data -R files/ personal/```

### Complete the Pydio setup ###

Open your web browser to: ```http://_your host address_:4100``` and follow the instructions. Enjoy!
