# linux-gui-docker (Xfce/VNC)

## Build and run the image
```
docker build -t vnc_ubuntu_xfce .
docker run -d -p 0.0.0.0:5901:5901 -e VNCPASS='trungtqt_vnc' -e VNCRES='1920x1080' --shm-size 2g vnc_ubuntu_xfce
```

## VNC Options
1. Set VNC color depth
Default value: 24 \
In order to set depth to 16:
```
-e VNCDEPTH='16'
```

2. Set VNC resolution
Default value: 1280x800
In order to change to 1920x1080:
```
-e VNCRES='1920x1080'
```

3. Change VNC port: the port of VNC will be `5900+VNCPORT`
Default value: 1, which is port 5901 \
In order to change to port 5909:
```
-e VNCPORT='9'
```

4. Password authentication for VNC session
Default value: No authentication
In order to set password to `vncpass`:
```
-e VNCPASS='vncpass'
```

5. Set Read-Write and Read-Only password
Default value: No authentication, user can perform access \
In order to set `vncpass` for full access session and `readonly` for read-only session:
```
-e VNCPASS='vncpass' -e VNCPASSRO='readonly'
```

6. Run the container as a new non-root user
Default value: root (UID: 0) will be the user when you login. \
In order to change the user inside the container to `guest` and having UID 1000 (normal user):
```
-e VNCUSER='guest' -e VNCUID='1000'
```

7. Set a password for the VNCUSER account (at 6)
Default value: none and the account is locked \
Requisites: VNCUSER and VNCUID must be set \
In order to set the password for the newly VNCUSER account:
```
-e ACCTPASS='mysecretpassword'
```

8. Add non-root user to a existing group
Default value: same as VNCUSER and VNCUID \
Requisites: VNCUSER and VNCUID must be set \
```
-e VNCGROUP='users'
```

9. Create a new group for the new non-root user
Default value: same as VNCUSER and VNCUID \
Requisites: VNCUSER and VNCUID must be set \
In order to create the new group `guests` with GID 1001:
```
-e VNCGROUP='guests' -e VNCGID='1001'
```

10. Set umask to define permission for new files/directories being created
Default value: 0022 \
In order to change umask to 0002:
```
-e VNCUMASK='0002'
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