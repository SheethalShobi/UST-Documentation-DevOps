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

-----
## Deployment (Deployment Controller)
- Provides **zero downtime upgrade**
- Controls Pods and ReplicaSets
- Ensures Pods are created and updated without disruption

### Example Flow
1. Deployment → ReplicaSet → Pods  
2. API Server watches Pods and maintains desired count  

### Rolling Update
- Adds new Pods → waits → deletes old Pods → continues until upgrade is done  
- Ensures **no downtime**  

---

## DaemonSet
- Ensures **a Pod runs on all nodes** in the cluster
- Even if a new node is added → Pod gets created automatically
- Example use cases:
  - `kube-proxy`
  - Monitoring agents (e.g., Prometheus node-exporter)

---

## Horizontal Pod Autoscaling (HPA)
- Adjusts the **number of replicas/pods** of an app based on CPU utilization or custom metrics
- Ensures scaling up/down depending on load

---

## Vertical Pod Autoscaling (VPA)
- Adjusts the **resources (CPU/RAM)** allocated to a Pod
- Has a limit (e.g., 2GB or 3GB depending on setup)

---

## Cluster Autoscaler
- When load increases beyond HPA limits → **Cluster Autoscaler (CA)** triggers
- CA checks if cluster is reaching limits → adds/removes nodes automatically
- Ensures workload is balanced across available nodes

---

# Kubernetes Services & Networking

---

## Services Overview
Kubernetes Services expose a set of Pods as a network service.  
There are four main types:

---

## 1. ClusterIP (Default)
- Exposes the service **inside the cluster** only.
- No external access.
- Used for internal communication between microservices.

---

## 2. NodePort
- Exposes the service on a **static port** (30000–32767) on each Node’s IP.
- External traffic can access the service via:
<NodeIP>:<NodePort>

- Simple but **not production friendly**.

---

## 3. LoadBalancer
- Exposes the service **externally using a cloud provider’s Load Balancer**.
- Supported in AWS, GCP, Azure, etc.
- Provides **public IP** for external access.
- Commonly used in production.

---

## 4. ExternalName
- Maps a service to an **external DNS name**.
- Returns a `CNAME` record in DNS.
- Useful to connect cluster services to external databases or APIs.

---

# Summary

| Service Type   | Accessible From | Use Case |
|----------------|-----------------|----------|
| ClusterIP      | Internal only   | Service-to-service communication |
| NodePort       | `<NodeIP>:Port` | Basic external access (testing) |
| LoadBalancer   | Public IP       | Production external access |
| ExternalName   | External DNS    | Connect to external services |

- **ClusterIP** should be created for each service.
---

## Pod-to-Pod Communication

### Q1: How do 2 containers in a pod talk to each other?
- By **Kernel capability**
- Any namespace can be attached to a number of processes.
- Containers in the same pod share the same **network namespace**.

---

### Q2: How do containers (C2 & C5) talk by IP?
- Pods are given **unique IP addresses**.
- Containers in different pods can communicate via pod IPs.

---

### Q3: How do containers in different machines talk?
- Each pod is connected via **CBR (Custom Bridge)** created by the network plugin.
- All pods connect to CBR (default one).
- If packet delivery fails → CBR sends traffic to the **network plugin**, which ensures correct delivery.

---

## Network Plugin
- Each network plugin implements communication in its own way.
- Example: Java has JVM; similarly Kubernetes has plugins like Calico, Flannel, Azure, etc.
- K8s specifies the **spec**, but plugins provide actual implementation.
- Hence, there are several algorithms.

---

## Service Communication

### Q4: How does a pod talk to a service & pass messages?
- **CBR → IP table**
- `kube-proxy` on each node already knows services (rules are synced from master node).
- Master node manages the service mappings.

---

## Encapsulation

- **IP-in-IP algorithm** is used for cross-node pod-to-pod communication.
- Plugins (e.g., **Calico, Flannel, Azure CNI**) have their own mechanisms.

---
Kubernetes DNS, StatefulSet, Ingress, and LoadBalancer

---

## DNS in Kubernetes
- Found in `/etc/resolv.conf`
- **CoreDNS (pod)** → runs as a deployment with 2 replicas
- Provides **name resolution** inside the cluster.

---

## StatefulSet
- Works **along with a Service**.
- Maintains **state information**.
- If an instance dies, it is recreated **on the same node** (if available).
- If the node is unavailable, pod is recreated on another node with the same identity.
- Example:
  - Suppose there are pods P, S, T, D.
  - If one pod crashes (say P), then **S will wait until P comes back** instead of replacing it.
- Ensures **ordered & stable identity** for pods.

---

## Ingress
- Provides **path-based routing** to services.
- Ingress Controller decides which microservice to call.
- Flow:  
  **Path → Service → ClusterIP**
- Example:
  - Ingress routes requests to different services through **Load Balancer**.

---

## LoadBalancer
- Provides **service discovery & traffic redirection**.
- Useful when exposing a service to **external customers**.
- Default: **Supported in cloud environments**.
- Advantages:
  - Directs traffic to multiple microservices.
  - Handles multiple backend instances.
- Disadvantages:
  - Public IPs cost more.
- Note:
  - Ingress should be connected with the LoadBalancer.

---
