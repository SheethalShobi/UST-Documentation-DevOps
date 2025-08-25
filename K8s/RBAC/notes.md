# Kubernetes RBAC (Role-Based Access Control)

RBAC is a method of regulating access to resources in Kubernetes based on the roles of individual users or service accounts. It defines **who can do what** on which resources.

---

## Core Concepts

1. **Role**  
   - Defines permissions (verbs like get, list, create, delete) for resources **within a specific namespace**.

2. **ClusterRole**  
   - Similar to Role but applies **cluster-wide** across all namespaces.

3. **RoleBinding**  
   - Grants the permissions defined in a Role to a user, group, or service account **within a specific namespace**.

4. **ClusterRoleBinding**  
   - Grants the permissions defined in a ClusterRole to a user, group, or service account **cluster-wide**.

---

## Example: Role and RoleBinding

The following Role allows a user to **list and get pods** in the `dev` namespace.

```yaml
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

---
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: dev
subjects:
- kind: User
  name: sheethal      # username
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
