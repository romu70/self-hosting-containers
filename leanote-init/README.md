# [Leanote-init](http://leanote.org/)

Container to store the Leanote initial data within your MongoDB instance. Taken from https://github.com/hannah98/docker-leanote-populatedb

Usage:

```docker run --rm -e MONGO_HOST=xxx.xxx.xxx.xxx -e MONGO_PORT=yyyyy -e LEANOTE_COLLECTION=leanote -e USER=leanote -e USER_PWD=blablabla leanote-init```

Default values provided:

- MONGO_PORT -> **27017**
- LEANOTE_COLLECTION -> **leanote**
- USER -> **leanote**

So if your mongo instance use these default values, you can just run:

```docker run --rm -e MONGO_HOST=xxx.xxx.xxx.xxx -e USER_PWD=blablabla  leanote-init```

