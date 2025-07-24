ubuntu@kmaster:~$ nano replicaset.yaml
ubuntu@kmaster:~$ kubectl get rs
No resources found in default namespace.
ubuntu@kmaster:~$ kubectl apply -f replicaset.yaml
replicaset.apps/nginx-replicaset created
ubuntu@kmaster:~$ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
nginx-replicaset   3         3         1       6s
ubuntu@kmaster:~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
my-nginx-pod             1/1     Running   0          10m
nginx-replicaset-vvgj8   1/1     Running   0          28s
nginx-replicaset-xvbck   1/1     Running   0          28s
ubuntu@kmaster:~$ kubectl get pods -o wide
NAME                     READY   STATUS    RESTARTS   AGE   IP          NODE      NOMINATED NODE   READINESS GATES
my-nginx-pod             1/1     Running   0          11m   10.44.0.1   kworker   <none>           <none>
nginx-replicaset-vvgj8   1/1     Running   0          42s   10.44.0.2   kworker   <none>           <none>
nginx-replicaset-xvbck   1/1     Running   0          42s   10.44.0.3   kworker   <none>           <none>
ubuntu@kmaster:~$ kubectl scale rs nginx-replicaset --replicas=5
replicaset.apps/nginx-replicaset scaled
ubuntu@kmaster:~$ kubectl delete rs nginx-replicaset
replicaset.apps "nginx-replicaset" deleted
ubuntu@kmaster:~$ kubectl get rs
No resources found in default namespace.
ubuntu@kmaster:~$
