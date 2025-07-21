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

## 📦 Important Docker Concepts

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
