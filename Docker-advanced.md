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

-------

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

----------


#### Copy on Write (CoW)

When something happens, it loads from the uppermost layer (latest).

CoW ensures efficiency.

Layers

Number of layers 1/∝ Performance issues

More layers = slower (container has to check all layers to find files)

Docker images are made of layers.

When a container modifies data, it uses CoW:

Original layer remains unchanged.

A new writable layer is created on top.



---------

1. Namespaces

Namespaces provide isolation for containers.

Types of namespaces:

1) Network space

UTS (Unix Timesharing System) space → hostname isolation

PID space → process isolation

IPC space → inter-process communication

Mount space → filesystem isolation

User space

Each container uses Linux namespaces for isolation.

2) Cgroups (Control Groups)

Used for resource allocation & limitation.

Limit container usage of:

CPU

Memory

I/O

Ensures containers are isolated and don’t consume all resources.

------
#### Docker Volumes

Volumes are used for persistent storage.

Types of Volumes

Anonymous volume

Named volume

Bind mounts (host path mapped to container path)

-----

Key Points

Data persists even if container is deleted.

Stored under:

/var/lib/docker/volumes/<volume_name>/_data


Volumes are managed by Docker (unlike bind mounts).

Can be shared between multiple containers.

-----

Commands:

```
docker volume create vol1
docker volume ls
docker run -v vol1:/path_in_container <image>
```

vol1:/path → Named volume

/path:/path → Bind mount

```

Removing
docker container prune   # remove stopped containers
docker volume prune      # remove unused volumes
docker image prune       # remove unused images
docker system prune      # cleanup (but will not remove volumes)
````


#### Docker Networking


IP Address → unique routable address (follows IP protocol).

Ethernet card (eth0) → default network interface.

Docker installs its own interface: docker0.

Containers are connected to bridge network via veth pairs.

NAT (Network Address Translation)

Container IPs are private.

NAT modifies source/destination IPs when packets move between host & container.

-------

#### Types of Docker Networks

- Bridge (default)

Each container gets its own IP.

NAT used for external communication.

Example: docker run -it --network bridge <image>

- Host

Container shares host’s network.

Same IP as host.

Restriction: cannot use same port twice.

- None

No networking.

Container is isolated (no IP).

Used when external networking is provided (e.g., Kubernetes CNI).

6. Example Commands
 ```
docker network ls          # list networks
docker network inspect bridge
docker run -dit --name c1 busybox
docker exec -it c1 sh
```
Number of layers depends on number of lines in Dockerfile
