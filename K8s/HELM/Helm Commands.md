# Basic Helm Commands Cheat Sheet

## Setup & Repositories
- **Add a Helm repo**
  ```bash
  helm repo add <repo_name> <repo_url>
  ```
  Example:
  ```bash
  helm repo add bitnami https://charts.bitnami.com/bitnami
  ```

- **List all repos**
  ```bash
  helm repo list
  ```

- **Update repo cache**
  ```bash
  helm repo update
  ```

- **Search for charts**
  ```bash
  helm search repo <keyword>
  ```

---

## Installing & Upgrading Charts
- **Install a chart**
  ```bash
  helm install <release_name> <repo_name>/<chart_name>
  ```
  Example:
  ```bash
  helm install my-nginx bitnami/nginx
  ```

- **Install with custom values**
  ```bash
  helm install <release_name> <chart> -f values.yaml
  ```

- **Upgrade an existing release**
  ```bash
  helm upgrade <release_name> <chart>
  ```

- **Upgrade with new values**
  ```bash
  helm upgrade <release_name> <chart> -f values.yaml
  ```

- **Upgrade (install if not exists)**
  ```bash
  helm upgrade --install <release_name> <chart>
  ```

---

## Listing & Inspecting
- **List installed releases**
  ```bash
  helm list
  ```

- **Show values of a chart**
  ```bash
  helm show values <repo_name>/<chart>
  ```

- **Get release values (current config)**
  ```bash
  helm get values <release_name>
  ```

- **Get all release details**
  ```bash
  helm get all <release_name>
  ```

---

## Uninstalling
- **Uninstall a release**
  ```bash
  helm uninstall <release_name>
  ```

- **Uninstall and purge history**
  ```bash
  helm uninstall <release_name> --keep-history=false
  ```

---


