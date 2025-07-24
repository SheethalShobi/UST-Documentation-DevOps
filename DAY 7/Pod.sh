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
