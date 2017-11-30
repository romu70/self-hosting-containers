# [MongoDB](https://www.mongodb.com/)

Some projects I use for self-hosting relie on MongoDB. So here are some instructions to get a proper setup.

1. Take the MongoDB provided in the Docker hub ()

2. Create a volume to keep your data on the host and not in the container itself.

```docker volume create mongo```

3. Run the Mongo image

```docker run --name mongo-3.4.10 -v mongo:/data/db -p 27017:27017 -d mongo:3.4.10 --auth```

4. Setup authentication

```
$ docker exec -it mongo-3.4.10 /bin/sh
# mongo admin
connecting to: admin
> db.createUser({ user: 'root', pwd: 'blablabla', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });
> exit

# mongo admin -u root -p 'blablabla'
```

