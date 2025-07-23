#### Running MySQL container with volume:

```
docker run -d -e MYSQL_ROOT_PASSWORD=admin -v /home/docker/mysql-data:/var/lib/mysql --name mysqlserver mysql
```

#### Accessing the container:

```
docker exec -it mysqlserver /bin/bash
```
#### Logging to MySQL:

```
mysql -u root -p
# Password: admin
```

#### Creating database and table:

```
CREATE DATABASE IF NOT EXISTS classicmodels DEFAULT CHARACTER SET latin1;
USE classicmodels;
```
```
CREATE TABLE customers (
  customerNumber INT PRIMARY KEY,
  customerName VARCHAR(50) NOT NULL
  -- Add other fields as needed
);
```
#### Exit MySQL and container:

```
exit
exit
```
#### Stopping and removing container:

```
docker stop mysqlserver
docker rm mysqlserver
```
#### Running new container with same volume:

```
docker run -d -e MYSQL_ROOT_PASSWORD=admin -v /home/docker/mysql-data:/var/lib/mysql --name mysqlserver2 mysql
```
### Verifying if the  data persists:

```
docker exec -it mysqlserver2 /bin/bash
mysql -u root -p
# Password: admin
```

```
SHOW DATABASES;
USE classicmodels;
SHOW TABLES;
```