# Create container
```
docker run -it -d --name=bamboo -h=bamboo -p 8085:8085 -p 8022:22 -p 54663:54663 cristo/bamboo /bin/bash
```
# SSH as root user
```
ssh -p1022 root@localhost
password: root
```

# etcKeeper 
Added etcKeeper - autocommit on exit to /etc git local repository

# Origin
[Docker Hub] (https://hub.docker.com/r/cristo/bamboo)
[Git Hub] (https://github.com/monte-fm/bamboo)