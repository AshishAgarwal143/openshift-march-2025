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

