# [Leanote](http://leanote.org/)

Docker setup to run Leanote. It uses an extenal MongoDB data back end. It currently runs Leanote 2.5.

1. Setup a [MongoDB](https://github.com/romu70/self-hosting-containers/tree/master/mongodb) instance
2. Populate the MongoDB instance with [initial Leanote data](https://github.com/romu70/self-hosting-containers/tree/master/leanote-init)
3. Setup the Leanote app.conf file, open a terminal with the conf folder and run:

```
./db-setup.sh IP_MONGO_DB PORT_MONGO_DB MONGO_USER MONGO_USER_PWD APP_SECRET IP_LEANOTE PORT_LEANOTE
``` 

4. Once the app.conf is correctly setup, it's time to run Leanote, locate the terminal in this folder and run:

```
docker run --name=leanote-2.5 -d -v $PWD/conf/app.conf:/src/leanote/conf/app.conf -p CONTAINER_PORT:9000 leanote:2.5
```

5. Enjoy!
