# [Paperwork](http://paperwork.rocks/) Deprecated

Docker setup to run Paperwork. It will use an external MariaDB/MySQL data back end.

1. Build the image

Put your terminal into this folder and run: 
```docker build -t paperwork .```

2. Create the database

Use the script at the root of this project.

3. Run the container

Run:
```docker run --name paperwork -d -p port:80 paperwork```

Change 'port' by the value your prefer.

4. Setup the database

Now, you need to get into the container to initialize the database settings.

```
docker exec -t -i paperwork /bin/bash
./db-setup.sh db-host db-port db-database db-user db-user-password
```

Of course, you need to change the value to suit your needs and preferences.

Enjoy!
