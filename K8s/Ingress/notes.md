# Kubernetes Ingress

Ingress is a Kubernetes API object that manages **external access** to services within a cluster, typically HTTP and HTTPS traffic. It provides **routing rules** to expose multiple services under a single IP or domain name.

---

## Why Use Ingress?

- Instead of exposing each service with a NodePort or LoadBalancer, Ingress provides:
  - **Single entry point** for the cluster
  - **Path-based routing** (e.g., `/app1` → service A, `/app2` → service B)
  - **Host-based routing** (e.g., `api.example.com` → backend service)
  - **SSL/TLS termination**
  - **Load balancing**

---

## Ingress Controller

Ingress itself is just a set of rules.  
To make it work, you need an **Ingress Controller**, such as:

- **NGINX Ingress Controller** (most popular)
- **HAProxy Ingress**
- **Traefik**
- **AWS/GCP/Azure Load Balancer controllers**

The controller watches for Ingress resources and configures a load balancer (like NGINX) to satisfy the rules.

---

## Example: Ingress Resource

Expose two services (`app1` and `app2`) under the same domain but different paths.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: app1-service
            port:
              number: 80
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: app2-service
            port:
              number: 80
