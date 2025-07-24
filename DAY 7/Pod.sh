Tried creating a pod

ubuntu@kmaster:~$ kubectl apply -f pod.yaml
error: the path "pod.yaml" does not exist
ubuntu@kmaster:~$ kubectl get pods
No resources found in default namespace.
ubuntu@kmaster:~$ nano pod.yaml
ubuntu@kmaster:~$ nano pod.yaml
ubuntu@kmaster:~$ kubectl apply -f mypod.yaml
error: the path "mypod.yaml" does not exist
ubuntu@kmaster:~$ kubectl apply -f pod.yaml
pod/my-nginx-pod created
ubuntu@kmaster:~$ kubectl get pods -o wide
NAME           READY   STATUS    RESTARTS   AGE    IP          NODE      NOMINATED NODE   READINESS GATES
my-nginx-pod   1/1     Running   0          102s   10.44.0.1   kworker   <none>           <none>
ubuntu@kmaster:~$ curl 10.44.0.1
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

ubuntu@kmaster:~$ kubectl describe pod
Name:             my-nginx-pod
Namespace:        default
Priority:         0
Service Account:  default
Node:             kworker/172.31.83.244
Start Time:       Thu, 24 Jul 2025 11:36:18 +0000
Labels:           app=nginx
Annotations:      <none>
Status:           Running
IP:               10.44.0.1
IPs:
  IP:  10.44.0.1
Containers:
  nginx:
    Container ID:   containerd://e8b6f015363fc43442bccf9ace3613f6950b8be3473946603fab4a16acb34cb5
    Image:          nginx:1.21
    Image ID:       docker.io/library/nginx@sha256:2bcabc23b45489fb0885d69a06ba1d648aeda973fae7bb981bafbb884165e514
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 24 Jul 2025 11:36:26 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-qcwqk (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-qcwqk:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  8m29s  default-scheduler  Successfully assigned default/my-nginx-pod to kworker
  Normal  Pulling    8m29s  kubelet            Pulling image "nginx:1.21"
  Normal  Pulled     8m21s  kubelet            Successfully pulled image "nginx:1.21" in 7.865999307s (7.866011268s including waiting)
  Normal  Created    8m21s  kubelet            Created container nginx
  Normal  Started    8m21s  kubelet            Started container nginx
