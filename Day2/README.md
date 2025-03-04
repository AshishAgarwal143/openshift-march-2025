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

