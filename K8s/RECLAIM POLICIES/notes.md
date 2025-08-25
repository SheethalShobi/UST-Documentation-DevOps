##  Reclaim Policies

Reclaim policy tells Kubernetes what to do with the underlying storage (PersistentVolume) when a PersistentVolumeClaim (PVC) is deleted.  

### Types of Reclaim Policies

1. **Retain**  
   - Keeps the PersistentVolume (PV) and its data even after the PVC is deleted.  
   - Use case: When data is critical and should not be automatically removed.  
   - Good for production databases.  

2. **Delete**  
   - Deletes both the PV and the storage resource in the cloud (e.g., AWS EBS, GCP PD, Azure Disk) when PVC is deleted.  
   - Good for temporary or test workloads.  

3. **Recycle** (deprecated)  
   - Performs a basic scrub (`rm -rf /data/*`).  
   - Deprecated and replaced by Dynamic Provisioning with storage classes.  

### Example: PersistentVolume with Reclaim Policy
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain   # or Delete
  hostPath:
    path: "/mnt/data"
```
