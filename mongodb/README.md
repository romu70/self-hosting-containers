# [MongoDB](https://www.mongodb.com/)

Some projects I use for self-hosting relie on MongoDB. So here are some instructions to get a proper setup.

1. Take the MongoDB provided in the Docker hub ()

2. Create a volume to keep your data on the host and not in the container itself.

```docker volume create mongo```

3. Run the Mongo image

```docker run --name mongo-3.4.10 -v mongo:/data/db -p 27017:27017 -d mongo:3.4.10 --auth```

4. Create the admin account

```
$ docker exec -it mongo-3.4.10 /bin/sh
# mongo admin
connecting to: admin
> db.createUser({ user: 'root', pwd: 'blablabla', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });
> exit
```

5. Create a database

```
$ docker exec -it mongo-3.4.10 /bin/sh
# mongo admin -u root -p 'blablabla'
connecting to: admin
> use mynewdb
```

6. Create the new user account

```
> db.createUser({ user: 'mynewuser', pwd: 'blobloblo', roles: [ { role: "readWrite", db: "mynewdb" }, {role: "dbAdmin", db: "mynewdb"} ] });
```

This way, the newly created account can admin but also read and write data.

7. Exit

Once the DB and the user created, you can exit the container.
