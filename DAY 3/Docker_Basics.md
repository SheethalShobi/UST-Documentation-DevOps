Docker

Docker is an open platform for developing, shipping, and running applications as containers.
Consistent, isolated environments
Fast development
Supports agile, CI/CD practices
Easy testing, collaboration, immutability


Container:
A standard unit of software that encapsulates everything needed to build, ship, and run applications.
Characteristics:
Virtualizes the OS
Lightweight
Fast, isolated, secure, uses less memory
Potability
Lower deployment time

Important Docker Concepts: mage,Container,Volumes,Networking

Docker Image:
An executable snapshot artifact — an immutable template that includes source code, complete environment config.

Docker Container:
Running instance of an image. Can run multiple containers from same image.

VM vs Docker
VM : Mimics a full machine
Docker: Lightweight, shares kernel with host
Docker is written to run on Linux kernel
Docker image contains all things necessary for running the app
Hypervisor: software to create/manage VMs
