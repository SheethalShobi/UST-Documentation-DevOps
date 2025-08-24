#### System Basics
- Boot Process
- BIOS
- MBR (Master Boot Record)
- Boot Loader
- OS
- Kernel

------
#### Virtual Machine (VM)

Isolated

Independent

Can have different OS running on the environment

#### Docker Containers

Containers do not have hypervisors.

Use kernel of the underlying host machine.

Do not have their own OS.

Example:

Why Ubuntu container crashes frequently while Nginx does not?

Ubuntu has no active process inside.

--------

Commands:
```

docker exec -it <container-name> /bin/bash → Access container shell

docker run ubuntu ps -ef → Shows all the processes in Ubuntu container

docker run -dit nginx ps -ef → Shows all processes in Nginx container
````
--------------
Writable Layer of Container

Stored in: /var/lib/docker

Even if container is killed, data & storage persist here.

We can start again using container ID.

------

#### Docker Images

Layered file systems

Found in graph driver location of container

Layers stored in root directory of overlay2

Default storage driver: overlay2

Stored in /var/lib/docker


#### Copy on Write (CoW)

When something happens, it loads from the uppermost layer (latest).

CoW ensures efficiency.

Layers

Number of layers ∝ Performance issues

More layers = slower (container has to check all layers to find files)

Number of layers depends on number of lines in Dockerfile
