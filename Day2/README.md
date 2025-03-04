# Day 2

## Lab - Stopping multiple containers without calling out their names
```
docker stop $(docker ps -q)
```

## Lab - Starting multiple containers without calling out their names
```
docker start $(docker ps -aq)
```

## Lab - Restarting multiple containers
```
docker restart $(docker ps -q)
```

## Lab - Deleting all the containers without calling out their names
```
docker rm -f $(docker ps -aq)
```

## Lab - Deleting container that matches a name pattern
```
docker rm -f $(docker ps -aq --filter "name=ubuntu")
```

## Lab - Renaming a container
```
docker rename current-container-name new-container-name
```

## Lab - Creating a container in interactive/foreground mode
```
docker run -it --name ubuntu5 --hostname ubuntu5 ubuntu:latest /bin/bash
ls -l
vim
ifconfig
ping 8.8.8.8
apt update && apt install -y net-tools iputils-ping tree vim
vim
ifconfig
ping 8.8.8.8
```

Expected output
![image](https://github.com/user-attachments/assets/64ebeb6f-7ead-4ab7-83c4-da466090f653)
![image](https://github.com/user-attachments/assets/f6b5d3a5-e59b-498e-99c2-35aa907fd863)
![image](https://github.com/user-attachments/assets/e9e04b41-fff7-4a31-b1fd-a15b0c46c054)
![image](https://github.com/user-attachments/assets/265b4693-f0ea-473a-a3c6-944056d22c78)

## Lab - Creating a mysql db container ( this is a bad practice - we shouldn't use container storage )
```
docker run -d --name mysql --hostame mysql -e MYSQL_ROOT_PASSWORD=root@123 mysql:latest
docker ps
```

Getting inside a container shell, when it prompts from mysql password, type 'root@123' without quotes
```
docker exec -it mysql /bin/bash
mysql -u root -p
SHOW DATABASES;
CREATE DATABASE tektutor;
USE tektutor;

SHOW TABLES;
CREATE TABLE training ( id INT NOT NULL, name VARCHAR(300) NOT NULL, duratio VARCHAR(300) NOT NULL, PRIMARY KEY(id) );
INSERT INTO training VALUES ( 1, "DevOps", "5 Days" );
INSERT INTO training VALUES ( 2, "Advanced Openshift", "10 Days" );
SELECT * FROM training;
exit
exit
```

Expected output
![image](https://github.com/user-attachments/assets/d7a64954-4e2e-4273-bf3b-8dc7d0c74224)
![image](https://github.com/user-attachments/assets/5aadddf4-e3b8-4300-a872-55cd52d9d8be)
![image](https://github.com/user-attachments/assets/8c64b38c-256f-4368-964f-1af3445790eb)


## Lab - Using volume mounting to storage data externally in mysql container ( This is the best practice )
Let's create a folder in the local system, replace my name with your name to avoid directory name conflicts
```
mkdir -p /tmp/jegan
```

Let's create a mysql container and mount the above path inside the container at mount point /var/lib/mysql
```
docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/jegan:/var/lib/mysql mysql:latest
docker ps
```

Getting inside the mysql container shell, when prompts for password type root@123 as the password
```
docker exec -it mysql /bin/sh
mysql -u root -p
SHOW DATABASES;
CREATE DATABASE tektutor;
USE tektutor;

SHOW TABLES;
CREATE TABLE training ( id INT NOT NULL, name VARCHAR(300) NOT NULL, duratio VARCHAR(300) NOT NULL, PRIMARY KEY(id) );
INSERT INTO training VALUES ( 1, "DevOps", "5 Days" );
INSERT INTO training VALUES ( 2, "Advanced Openshift", "10 Days" );
SELECT * FROM training;
exit
exit
```

Let's delete the container
```
docker rm -f mysql
```

Let's recreate a new container and mount the same local path
```
docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/jegan:/var/lib/mysql mysql:latest
docker ps
docker exec -it mysql /bin/sh
mysql -u root -p
SHOW DATABASES;
USE tektutor;
SHOW TABLES;
SELECT * FROM training;
exit
exit
```

As you noticed, though we deleted the original mysql container that created the table and inserted data is gone, we are able to access the data via another container using docker volume mounting.

## Lab - Setting up a Load Balancer with port forwarding using nginx docker image

Let's create 3 web server container using nginx:latest docker image from Docker Hub Remote Registry
```
docker run -d --name server1 --hostname server1 nginx:latest
docker run -d --name server2 --hostname server2 nginx:latest
docker run -d --name server3 --hostname server3 nginx:latest
docker ps
```

Let's find the IP address of the above containers
```
docker inspect -f {{.NetworkSettings.IPAddress}} server1
docker inspect -f {{.NetworkSettings.IPAddress}} server2
docker inspect server1 | grep IPA
```

Let's copy the nginx.conf from one of the web server to the current directory
```
docker cp server1:/etc/nginx/nginx.conf .
```

Let's edit the nginx.conf as shown below ( you could create this file anywhere on the local machine )
<pre>

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}

http {
    upstream backend {
        server 172.17.0.2:80;
        server 172.17.0.3:80;
        server 172.17.0.4:80;
    }

    server {
        location / {
            proxy_pass http://backend;
        }
    }
} 
</pre>

Let's create the lb container using nginx:latest docker image
```
docker run -d --name lb --hostame lb -p 80:80 nginx:latest
docker ps
```

We need to configure the lb configure to make it work like a Load Balancer, hence let's copy the nginx.conf we prepared into it and reboot the container.  

Please note that, wherever you created the nginx.conf on your lab machine, you need to navigate to that directory before running the below command
```
docker cp nginx.conf lb:/etc/nginx/nginx.conf
docker restart lb
docker ps
```

In order to differentiate to which server the load balancer redirected our call, let's customize their html pages
```
echo "Server 1" > index.html
docker cp index.html server1:/usr/share/nginx/html

echo "Server 2" > index.html
docker cp index.html server2:/usr/share/nginx/html

echo "Server 3" > index.html
docker cp index.html server3:/usr/share/nginx/html
```

Let's verify the response of server1
```
curl http://172.17.0.2:80
```

Let's verify the response of server2
```
curl http://172.17.0.3:80
```

Let's verify the response of server3
```
curl http://172.17.0.4:80
```

Let's test our load balancer, you can open the below from your ubuntu cloud machine web browser
```
http://localhost:80
```
