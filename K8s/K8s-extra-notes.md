# Kubernetes Notes

## Master Node Components

### 1. ETCD
- Stores data as **key-value pairs**
- NoSQL database → highly scalable
- Stores everything about the cluster state

### 2. API Server
- Acts as the **front-end** for Kubernetes
- Exposes **REST API**
- Responsibilities:
  - Authorize
  - Authenticate
  - Validate requests
- Communicates with **ETCD**

### 3. Scheduler
- Works on **event-driven architecture**
- Finds the **best node** to create a Pod
- Before updating ETCD → must talk with **API Server**

### 4. Controller
- Ensures everything is running as expected
- Continuously checks:
  - **Desired state** vs **Current state**
  - If unmatched → takes corrective action

---

## Worker Node Components

### 1. Kubelet
- Only service on node that is **not a Pod**
- Talks to API Server and Scheduler
- Responsible for:
  - Managing Pods on node
  - Creating containers via container runtime (CRI)
- Command to start:
  ```bash
  systemctl start kubelet
2. Kube-proxy
Runs on all nodes

Manages networking of all nodes

Handles service discovery and load balancing

3. CRI (Container Runtime Interface)
Component that actually runs the containers

Examples: Docker, containerd, CRI-O

#### Pod
Simplest and smallest unit in Kubernetes

Represents one or more containers

##### Characteristics:
Containers in a Pod are:
- Colocated (same host)
- Coscheduled (start at same time)
- Share certain namespaces: Network namespace, Filesystem namespace
