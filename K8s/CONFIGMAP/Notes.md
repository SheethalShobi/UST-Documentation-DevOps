# Kubernetes ConfigMaps - Overview and Usage

ConfigMaps are a Kubernetes mechanism that let you inject configuration data into application pods.

The ConfigMap concept allow you to decouple configuration artifacts from image content to keep containerized applications portable.  

Allows to externalize property files or properties from applications management and expose configuration data to applications in a key-value format.

Many applications rely on configuration which is used during either application initialization or runtime. Most times, there is a requirement to adjust values assigned to configuration parameters.

---

## Features

### Configuration Storage
- ConfigMaps store configuration data as key-value pairs.
- They can hold simple configuration settings, environment variables, configuration files.

### Decoupling Configuration
- Easily manage and update configurations without modifying the application's source code.

### How to inject ConfigMap to container
- **Pod Environment Variables**:  
  Can inject configuration data as environment variables into the containers within a pod.  

- **Volume Mounts**:  
  ConfigMaps can be mounted as volumes in a pod.  
  Thus containers can access the configuration data as files.  

### Immutability and Versioning
- ConfigMaps themselves are immutable, but you can create new versions by updating them with different data.
- This allows you to maintain a history of configurations and roll back to a previous state if needed.

### Multi-environment Support
- ConfigMaps are especially useful in multi-environment setups.  
  e.g., development, testing, production etc where configurations may differ.

---

## Steps to create ConfigMap

```bash
kubectl create configmap <map-name> <data-source>
```

- `<map-name>` is the name you want to assign to the ConfigMap.  
- `<data-source>` is the directory, file, or literal value to draw the data from.  

The name of a ConfigMap object must be a valid DNS subdomain name.  
When you are creating a ConfigMap based on a file, the key in the `<data-source>` defaults to the basename of the file, and the value defaults to the file content.  

Use `kubectl describe` or `kubectl get` to retrieve information about a ConfigMap.

---

## Create a ConfigMap from a directory

You can use `kubectl create configmap` to create a ConfigMap from multiple files in the same directory.  
When you are creating a ConfigMap based on a directory, kubectl identifies files whose filename is a valid key in the directory and packages each of those files into the new ConfigMap.  

Any directory entries except regular files are ignored (for example: subdirectories, symlinks, devices, pipes, and more).

### Example

```
Name:         game-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
game.properties:
----
enemies=aliens
lives=3
enemies.cheat=true
enemies.cheat.level=noGoodRotten
secret.code.passphrase=UUDDLRLRBABAS
secret.code.allowed=true
secret.code.lives=30
ui.properties:
----
color.good=purple
color.bad=yellow
allow.textmode=true
how.nice.to.look=fairlyNice
```

The `game.properties` and `ui.properties` files in the `configure-pod-container/configmap/` directory are represented in the data section of the ConfigMap.

---

## Create ConfigMaps from files

```bash
kubectl create configmap game-config-2 --from-file=configure-pod-container/configmap/game.properties
```

```
Name:         game-config-2
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
game.properties:
----
enemies=aliens
lives=3
enemies.cheat=true
enemies.cheat.level=noGoodRotten
secret.code.passphrase=UUDDLRLRBABAS
secret.code.allowed=true
secret.code.lives=30
```

You can pass in the `--from-file` argument multiple times to create a ConfigMap from multiple data sources.

---

## Creating ConfigMap from multiple files

```bash
kubectl create configmap game-config-2   --from-file=configure-pod-container/configmap/game.properties   --from-file=configure-pod-container/configmap/ui.properties
```
```
Name:         game-config-2
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
game.properties:
----
enemies=aliens
lives=3
enemies.cheat=true
enemies.cheat.level=noGoodRotten
secret.code.passphrase=UUDDLRLRBABAS
secret.code.allowed=true
secret.code.lives=30
ui.properties:
----
color.good=purple
color.bad=yellow
allow.textmode=true
how.nice.to.look=fairlyNice
```
