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

## Create a .dockerignore file to exclude unnecessary files.

### Multi -stage builds
Multi-stage builds let you use multiple FROM statements in one Dockerfile. 
Why Use Multi-Stage Builds?
Smaller final images 
Better security 
Cleaner separation 
