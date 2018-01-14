# Introduction

This repository contains stuff for self-hosting. Self hosting of services is based on Docker containers, and I assume you have access to a MySQL/MariaDB database server (which can be a Docker container as well but in my case it's run by the physical server).

This repository doesn't deal with SSL, certificates etc. My own server already provides a nice GUI to setup SSL reverse proxy and Let's Encrypt certificates, but feel free security related stuff.

# Utilities

You can find 2 scripts (create-db.sh and delete-sb.sh) at the root of this repsitory. The first one is to create a couple database/user to store the data for a particular service, should be run before the container to initiate the data back end. The second script (delete-db.sh) should be used only for debug and development purposes, but also if you want to get rif off a service (and its data) for good, use it CAREFULLY.

# Services

Here is a list of services I run:

[Wallabag](https://www.wallabag.org/)

[Miniflux](https://www.miniflux.net/)

[NextCloud](https://www.nextcloud.com/)

[Paperwork](https://www.paperwork.rocks/)

[Leanote](https://www.leanote.org/) - Deprecated, I don't use it

[Tiny Tiny RSS](https://tt-rss.org/gitlab/fox/tt-rss/wikis/home) - Deprecated, I don't use it'

[Pydio](https://www.pydio.com/) - Deprecated, I don't use it


