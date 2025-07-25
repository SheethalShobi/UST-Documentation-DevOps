### Initialization 
```
kubeadm init
```
### checking Node Status
```
kubectl get node
```
will show the node in "NotReady" status
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### Setting up the necessary network layer for Pods to communicate.

```
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
```
### Waiting for System Pods to Become Ready
```
watch -n 1 kubectl get po -n kube-system
```
wait until all pods changes to "1/1" or "2/2" "Running"
```
kubectl describe node | grep -i taint
```
copying the taint 
```
kubectl get node 
```
copying the name  of node 
```
kubectl taint node <node name from above command> node-role.kubernetes.io/control-plane:NoSchedule-
```
```
kubectl run nginx --image=nginx
```
```
kubectl get po
```
```
kubectl get po -o wide
```
note down the ip 
```
curl <ip>
```
should see nginx output
