### Kubernetes
While Docker runs containers on a single machine, Kubernetes manages containers across multiple machines, making sure they stay healthy, can handle traffic, and automatically recover from failures.

#### Kubernetes Objects
- **Pod: The smallest unit that runs your container
- **ReplicaSet: Ensures you have the right number of pods running
- **Deployment: Manages ReplicaSets and handles updates
- **Service: Provides a stable way to access your pods

### Pod
A Pod is the smallest and simplest unit in Kubernetes. It's like a wrapper around one or more containers that need to work closely together.
**contains just one container
- **Containers in a pod share the same network and storage
- **pods are temporary 
- **each pod gets its own IP addressIf a pod dies, it's gone forever (not restarted)

### Pod Lifecycle
- **Pending: Pod is created but containers aren't running yet
- **Running: Pod is running on a node and at least one container is active
- **Succeeded: All containers completed successfully
- **Failed: At least one container failed
- **Unknown: Pod status couldn't be determined

Pods are not permanent: If a pod crashes, it's gone. You need something to restart it. No load balancing: A single pod can't handle lots of traffic. This is where ReplicaSets and Deployments come in.

Nodes are basically there for either physical or virtual machine.
Types :
###### Control Plane / MASTER node
###### Data Plane / WORKER node

- **Master nodes creates pods while them getting actually created on worker node by default.
- **If the pod crashes,K8 will replace it
- **Once you deploy a pod from version v1 to version2 and v2 has various instances of it,then all the v2's gets updated.
- **It is easy to update,scale and deploy pods ie. AUTOSCALING
- **Apart from this,K8 also has cluster scaling,vertical scaling etc..

- **2 pods communicate to each other through K8 Services.
- **A pod can have a group of 1 or more containers ie by creating a pod it is possible to create multiple containers.
- **All containers in the pod shares same namespace.

###### Kubectl - client /command line arg
talks to API server,which then to scheduler - etcd via API server, which ultimately talk to kubelet which further then to CRI.
##### Master node has :

- **API server (basically a Rest server )
- **ETCD
- **Scheduler ( finds which is the best machine to create pod)
- **Controller (if the desired state not matches current state,then controller comes into play )

##### Worker node has :

- **Kubelet (talks to API server and then API server does 4 things mainly: AUTHORIZE,AUTHENTICATE,VALIDATE, talks to ETCD)
- **Kubeproxy ( for networking all nodes)
- **Container Runtime [CRI]
