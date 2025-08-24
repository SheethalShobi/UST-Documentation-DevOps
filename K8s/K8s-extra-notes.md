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


### Example
| Name   | Image  | Node    | Desired State | Current State |
|--------|--------|---------|---------------|----------------|
| podpod | nginx  | worker1 | Running       | Running        |

---

### Pod Lifecycle
1. The moment an entry is created in table → **Scheduler** is triggered  
   → assigns worker node  
2. API Server → Kubelet (on worker) → CRI → Pod created  
3. If a container goes down, **Kubelet automatically fixes it** by creating a new one in the same Pod  

**Kube-proxy + Kubelet ensure automatic failover**

---

## ReplicaSets
- Used for **traceability** and scaling Pods
- YAML files define desired replicas

### Command:
```bash
kubectl create rs rsname --image=nginx --replicas=5
```
Flow:
kubectl → API Server → Authorization, Authentication, Validation → entry added in table

Replication Controller watches the table (desired state vs current state)

If mismatch → Scheduler assigns nodes and updates table

 Works on Event Driven Architecture

 ------

Production Architecture
Control Plane (Masters)
Multiple master nodes (m1, m2, m3) for high availability

Load balancer / reverse proxy used for traffic distribution

etcd uses Raft consensus algorithm for leader election

Data Plane (Workers)
Multiple worker nodes (w1, w2, w3, w4, w5)

-----

Communication

Master → Worker: Direct communication

Worker → Master: Via API Server (doesn’t know which master is leader)

-----

Key Points :

kubelet present on worker → knows how to talk to master

Workers consult API Server to find master when initiating requests
