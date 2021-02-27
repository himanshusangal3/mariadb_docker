# MariaDB Dockerfile

###Clone this repositry from below URL

```
git clone https://github.com/himanshusangal3/mariadb_docker.git
```
###Then go into the directory
```
cd mariadb_docker/
```

### Build the image

To create the image `mariadb`, execute the following command on the `docker-mariadb` folder:

```
$ docker build -t mariadb:1.0 .
```


### Run the image

To run the image and bind to host port 3306:

```
$ docker run -d --name mariadb -p 3306:3306 mariadb:1.0
```

The first time you run your container, a new user `admin` with all privileges will be created with a random password.
To get the password, check the logs of the container by running:

```
docker logs <CONTAINER_ID>
```

You will see an output like the following:

```
========================================================================
MySQL User: "admin"
MySQL Password: "mKHBsVb2i7OrY26K"
========================================================================
```

#### Credentials

If you want to preset credentials instead of a random generated ones, you can set the following environment
variables:

* `MYSQL_USERNAME` to set a specific username
* `MYSQL_PASSWORD` to set a specific password

On this example we will preset our custom username and password:

```
$ docker run -d \
    --name mariadb \
    -p 3306:3306 \
    -e MYSQL_USERNAME=root \
    -e MYSQL_PASSWORD=changeit \
    mariadb:1.0
```

#### Databases

If you want to create a database at container's boot time, you can set the following environment variables:

* `MYSQL_DBNAME` to create a database

On this example we will preset our custom username and password and we will create a database:

```
$ docker run -d --name mariadb -p 3306:3306 -e MYSQL_USERNAME=root -e MYSQL_PASSWORD=changeit -e MYSQL_DBNAME=wiki mariadb:5.0
```

###Verify that Go inside the container
```
$ docker exec -it mariadb bash
```

### Run below command to connect
```
root@435ce304f48c:/data# mysql
```

### Run below command to verify databases
```
MariaDB [(none)]> SHOW DATABASES;
```

