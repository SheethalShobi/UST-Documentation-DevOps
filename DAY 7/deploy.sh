root@kmaster:/home/ubuntu# nano deploy.yaml
root@kmaster:/home/ubuntu# kubectl apply -f deployment.yaml
error: the path "deployment.yaml" does not exist
root@kmaster:/home/ubuntu# kubectl apply -f deploy.yaml
deployment.apps/nginx-deployment configured
root@kmaster:/home/ubuntu# kubectl get deploy
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           24h
root@kmaster:/home/ubuntu# kubectl get po,rs
NAME                         READY   STATUS             RESTARTS         AGE
pod/javapod                  0/1     CrashLoopBackOff   98 (3m33s ago)   18h
pod/mypod                    1/1     Running            2 (51m ago)      24h
pod/nginx-replicaset-6ccx4   1/1     Running            0                19s
pod/nginx-replicaset-vbnlq   1/1     Running            0                16s
pod/nginx-replicaset-zggjx   1/1     Running            0                17s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-f5d9744f   0         0         0       24h
replicaset.apps/nginx-replicaset            3         3         3       8m27s
root@kmaster:/home/ubuntu# kubectl delete pod nginx-replicaset-zggjx
pod "nginx-replicaset-zggjx" deleted
root@kmaster:/home/ubuntu# kubectl get po,rs
NAME                         READY   STATUS             RESTARTS         AGE
pod/javapod                  0/1     CrashLoopBackOff   98 (4m20s ago)   18h
pod/mypod                    1/1     Running            2 (51m ago)      24h
pod/nginx-replicaset-27nbz   1/1     Running            0                5s
pod/nginx-replicaset-6ccx4   1/1     Running            0                66s
pod/nginx-replicaset-vbnlq   1/1     Running            0                63s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-f5d9744f   0         0         0       24h
replicaset.apps/nginx-replicaset            3         3         3       9m14s
root@kmaster:/home/ubuntu# kubectl set image deploy/nginx-deploy nginx=nginx:1.22
Error from server (NotFound): deployments.apps "nginx-deploy" not found
root@kmaster:/home/ubuntu# kubectl get po,rs,deploy
NAME                         READY   STATUS      RESTARTS         AGE
pod/javapod                  0/1     Completed   99 (5m28s ago)   18h
pod/mypod                    1/1     Running     2 (53m ago)      24h
pod/nginx-replicaset-27nbz   1/1     Running     0                73s
pod/nginx-replicaset-6ccx4   1/1     Running     0                2m14s
pod/nginx-replicaset-vbnlq   1/1     Running     0                2m11s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-f5d9744f   0         0         0       24h
replicaset.apps/nginx-replicaset            3         3         3       10m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           24h
root@kmaster:/home/ubuntu# kubectl set image deployment/nginx-deployment nginx=nginx:1.22
deployment.apps/nginx-deployment image updated
root@kmaster:/home/ubuntu# kubectl rollout status deployment/nginx-deploymen
Error from server (NotFound): deployments.apps "nginx-deploymen" not found
root@kmaster:/home/ubuntu# kubectl rollout status deploy/nginx-deploymen
Error from server (NotFound): deployments.apps "nginx-deploymen" not found
root@kmaster:/home/ubuntu# kubectl set image deploy/nginx-deployment nginx=nginx:1.22
root@kmaster:/home/ubuntu# kubectl rollout status deployment/nginx-deployment
deployment "nginx-deployment" successfully rolled out
root@kmaster:/home/ubuntu# kubectl describe deployment nginx-deployment | grep Image
    Image:        nginx:1.22
root@kmaster:/home/ubuntu# kubectl rollout status deployment/nginx-deployment
deployment "nginx-deployment" successfully rolled out
root@kmaster:/home/ubuntu# kubectl get pods -o wide
NAME                              READY   STATUS             RESTARTS         AGE     IP          NODE              NOMINATED NODE   READINESS GATES
javapod                           0/1     CrashLoopBackOff   99 (2m51s ago)   18h     10.32.0.7   ip-172-31-89-73   <none>           <none>
mypod                             1/1     Running            2 (55m ago)      24h     10.32.0.4   ip-172-31-89-73   <none>           <none>
nginx-deployment-8cf4bf97-gw5k9   1/1     Running            0                2m2s    10.32.0.8   ip-172-31-89-73   <none>           <none>
nginx-deployment-8cf4bf97-l6xc4   1/1     Running            0                2m1s    10.32.0.5   ip-172-31-89-73   <none>           <none>
nginx-deployment-8cf4bf97-ml5xl   1/1     Running            0                2m12s   10.32.0.6   ip-172-31-89-73   <none>           <none>
