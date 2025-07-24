### Kubernetes
While Docker runs containers on a single machine, Kubernetes manages containers across multiple machines, making sure they stay healthy, can handle traffic, and automatically recover from failures.

#### Kubernetes Objects
- Pod: The smallest unit that runs your container
- ReplicaSet: Ensures you have the right number of pods running
- Deployment: Manages ReplicaSets and handles updates
- Service: Provides a stable way to access your pods

### Pod
A Pod is the smallest and simplest unit in Kubernetes. It's like a wrapper around one or more containers that need to work closely together.
- contains just one container
- containers in a pod share the same network and storage
- pods are temporary 
- each pod gets its own IP addressIf a pod dies, it's gone forever (not restarted)

### Pod Lifecycle
- Pending: Pod is created but containers aren't running yet
- Running: Pod is running on a node and at least one container is active
- Succeeded: All containers completed successfully
- Failed: At least one container failed
- Unknown: Pod status couldn't be determined

Pods are not permanent: If a pod crashes, it's gone. You need something to restart it. No load balancing: A single pod can't handle lots of traffic. This is where ReplicaSets and Deployments come in.

Nodes are basically there for either physical or virtual machine.
Types :
###### Control Plane / MASTER node
###### Data Plane / WORKER node

- Master nodes creates pods while them getting actually created on worker node by default.
- If the pod crashes,K8 will replace it
- Once you deploy a pod from version v1 to version2 and v2 has various instances of it,then all the v2's gets updated.
- It is easy to update,scale and deploy pods ie. AUTOSCALING
- Apart from this,K8 also has cluster scaling,vertical scaling etc..

- 2 pods communicate to each other through K8 Services.
- A pod can have a group of 1 or more containers ie by creating a pod it is possible to create multiple containers.
- All containers in the pod shares same namespace.

###### Kubectl - client /command line arg
talks to API server,which then to scheduler - etcd via API server, which ultimately talk to kubelet which further then to CRI.
##### Master node has :

- API server (basically a Rest server )
- ETCD
- Scheduler ( finds which is the best machine to create pod)
- Controller (if the desired state not matches current state,then controller comes into play )

##### Worker node has :

- Kubelet (talks to API server and then API server does 4 things mainly: AUTHORIZE,AUTHENTICATE,VALIDATE, talks to ETCD)
- Kubeproxy ( for networking all nodes)
- Container Runtime [CRI]

```
hostnamectl set-hostname kmaster
```
 Sets the system hostname to kmaster.
```
kubeadm init
```
 Initializes the Kubernetes control-plane (master) node.
```
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
```
 Deploys the Weave Net CNI plugin for Kubernetes networking.
```
watch -n 1 kubectl get po -n kube-system
```
 Continuously monitors the status of system pods in the kube-system namespace every 1 second.
```
kubectl run podname --image=nginx
```
 Creates a pod named mypod using the Nginx image.
```
kubectl get pod -o wide
```
 Lists all pods with extra info like node name and IP.
```
curl <ip>
```
 Sends a web request to the pod's IP to verify if the Nginx server is accessible. 
```
kubetcl get pod/rs/deploy
```
```
kubectl describe pod
```
```
kubectl apply -f ng-pod.yaml/replicaset.yaml/deploy.yaml
```
```
kubectl delete pod -all
```
```
kubectl delete -f replicaset.yaml
```
##### Replicaset
- A ReplicaSet ensures that a specified number of pod replicas are running at any given time. If a pod crashes or is deleted, the ReplicaSet automatically creates a new one.
