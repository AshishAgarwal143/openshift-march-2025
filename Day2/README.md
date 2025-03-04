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

