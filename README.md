# linux-gui-docker (Xfce/RDP)

Docker image of Ubuntu 22.04 running Xfce4 desktop environment, remotely controlled through RDP. Optimized for programming and redteam operations.

## Build and run the image
```bash
docker build -t ubuntu_xfce_rdp .
docker run -d -p 0.0.0.0:3389:3389 -e RDPUSER='ubuntu' -e RDPPASS='ubuntupass' -e RDPUID='1000' --shm-size 2g ubuntu_xfce_rdp
```

## Docker Compose for a quick run
`docker compose -d` will run the project with default setting: RDP on `:3389`.

## RDP Options
### (Mandatory) Create a new non-root account with password
In order to create `ubuntu` account with password `ubuntupass`, having the UID 1000:
```
-e RDPUSER='ubuntu' -e RDPUID='1000' -e RDPPASS='ubuntupass'
```

### Add your non-root user to an existing group
In order to add your RDPUSER account to `users` group:
```
-e RDPGROUP='users'
```

### Create a new group for your non-root user
In order to add your RDPUSER account to a new `guests` group having GID 1001:
```
-e RDPGROUP='guests' -e RDPGID='1001'
```

## Sound Configuration (to support audio)
Passthrough for audio devices inside the container
```
--device /dev/snd
or
--privileged
```

## FUSE Configuration (to support AppImages)
Set privileges to allow FUSE to work properly inside the container
```
--device /dev/fuse --cap-add SYS_ADMIN
```

## Privileged Mode (to support FlatPak)
Set privileged mode to allow FlatPaks to work properly inside the container
```
--privileged
```

## Shared Memory Modification (to support Web Browsers)
Increase the size of shared memory to prevent web browsers from crashing \
Thanks to [jlesage](https://hub.docker.com/r/jlesage/firefox/#increasing-shared-memory-size)
```
--shm-size 2g
```

## Credit
This project is a modified version of @Fullaxx [ubuntu-desktop](https://github.com/Fullaxx/ubuntu-desktop).