# Docker 

Docker is an open platform for developing, shipping, and running applications as **containers**.

## Key Benefits
- **Consistent, isolated environments**
- **Fast development**
- **Supports Agile & CI/CD practices**
- **Easy testing, collaboration**
- **Immutability**

---

## Container

A **container** is a standard unit of software that encapsulates everything needed to build, ship, and run applications.

###  Characteristics:
- Virtualizes the **Operating System**
- Lightweight and fast
- Isolated and secure
- Uses less memory
- Portable across environments
- Low deployment time

---

##  Important Docker Concepts

### 1. Docker Image
- An **immutable executable snapshot** of an application
- Contains:
  - Application source code
  - Runtime
  - Libraries & dependencies
  - Environment variables & configuration

### 2. Docker Container
- A **running instance** of a Docker image
- Can have **multiple containers** from the same image
- Ephemeral by default (unless persisted using volumes)

### 3. Volumes
- **Persistent storage** mechanism for containers
- Useful for saving data across container restarts

### 4. Networking
- Docker provides **isolated networks** for containers
- Enables inter-container communication and access to external services

---

##  Docker vs Virtual Machines (VMs)

| Feature             | Docker                          | Virtual Machine (VM)         |
|---------------------|----------------------------------|-------------------------------|
| Virtualization Type | OS-level                        | Hardware-level                |
| Resource Usage      | Low                             | High                          |
| Startup Time        | Seconds                         | Minutes                       |
| Isolation           | Process-level                   | Full OS-level                 |
| Kernel              | Shares host kernel              | Own kernel per VM             |
| Performance         | Near-native                     | Slight overhead               |
| Use Case            | Lightweight apps, microservices | Full OS, legacy apps          |

- **Hypervisor**: Software like VirtualBox or VMware used to create and manage VMs.
- **Docker Engine**: Written to run on the **Linux kernel** and manages containers.

---

# Dockerfile 

A **Dockerfile** is a script containing a series of **step-by-step instructions** that Docker uses to build an image of your application.



- Use `#` to write comments and explain each step

## Common Dockerfile Instructions

| Instruction | Purpose | Example |
|------------|---------|---------|
| FROM       | Sets the base image | `FROM python:3.11-slim` |
| WORKDIR    | Sets the working directory inside the container | `WORKDIR /app` |
| COPY       | Copies files from your system to the container | `COPY requirements.txt .` <br> `COPY . .` |
| RUN        | Executes commands while building the image | `RUN pip install -r requirements.txt` |
| EXPOSE     | Informs Docker which port the container will use | `EXPOSE 8000` |



```dockerfile
COPY requirements.txt .
COPY . .
# First line copies just the requirements file
# Second line copies everything else
```
----
# Docker Notes

---

## .dockerignore

Create a `.dockerignore` file to exclude unnecessary files.

---

## Multi-Stage Builds

**Multi-stage builds** let you use multiple `FROM` statements in one Dockerfile.

### Why Use Multi-Stage Builds?

- **Smaller final images**  
- **Better security**  
- **Cleaner separation**

---

## The Problem with Container Storage

When you run a Docker container, any data you create inside it disappears when the container stops.  
This is because containers use **ephemeral storage** – temporary and not persistent.

---

## Solutions

### 1. **Bind Mounts**  
Creating a direct connection between a folder on your computer and a folder inside the container.

#### How it works:

- Pick a folder on your host machine (like `/home/user/myapp`)  
- Connect it to a folder inside the container (like `/app`)  
- Both folders now show the same files

---

## Docker Networking

### Why Docker Networking Matters

When you have multiple containers and they need to communicate with each other, networking becomes essential.

---

### 1. Bridge Network

A **private network inside your computer** where containers can talk to each other.

#### Comparison: Default Bridge vs Custom Bridge

| Feature                      | Default Bridge Network                                     | Custom Bridge Network                                           |
|-----------------------------|-------------------------------------------------------------|-----------------------------------------------------------------|
| Communication               | All containers can communicate with each other             | Only containers you specify can communicate                    |
| Isolation                   | Not very secure because there's no isolation               | More secure with better isolation                              |
| Addressing                  | Containers reach each other using IP addresses             | Containers can reach each other using names (not just IPs)     |

---

### 2. Host Network

- The container uses **your computer's network directly**  
- It's like the container is running directly on the host machine

---

### 3. Overlay Network

- Used when **containers on multiple computers** need to communicate  
- **Better performance**, no port mapping needed  
- **Less secure** and **less portable**

---

## Docker Network Commands

| Action                            | Command                                                  |
|-----------------------------------|----------------------------------------------------------|
| List networks                     | `docker network ls`                                      |
| Create a new network              | `docker network create my_network`                       |
| Inspect details of a network      | `docker network inspect my_network`                      |
| Connect container to a network    | `docker network connect my_network my_container`         |
| Disconnect container from network | `docker network disconnect my_network my_container`      |

---


