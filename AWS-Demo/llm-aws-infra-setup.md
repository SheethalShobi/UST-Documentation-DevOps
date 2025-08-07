#### 1. VPC Setup (Virtual Private Cloud)
VPC (Virtual Private Cloud) is your isolated network within AWS.
```
🔹 Step-by-Step:
VPC Dashboard: Go to AWS Console → VPC → "Create VPC"
Name: llm-vpc
CIDR Block: 10.0.0.0/16 – This gives you 65,536 private IPs
Tenancy: Default (shared hardware)
```
----
🔹 Subnet Creation:
You need at least:
- 2 Public Subnets: For Load Balancers or Bastion Host
- 2 Private Subnets: For your EKS worker nodes and services

----
```
Example:
Public Subnet 1: 10.0.1.0/24 (us-east-1a)
Public Subnet 2: 10.0.3.0/24 (us-east-1b)
Private Subnet 1: 10.0.2.0/24 (us-east-1a)
Private Subnet 2: 10.0.4.0/24 (us-east-1b)
```
----
🔹 Internet Gateway:
- Used to provide internet access to public subnets.
- After creation, attach it to the VPC.
🔹 Route Table:
- For public subnets: Create a route table → Add route 0.0.0.0/0 → Target = Internet Gateway → Associate to public subnets.\

----

 2. IAM Configuration
IAM ensures secure access control across your AWS infrastructure.
```
🔹 EKS Cluster Role:
Go to IAM → Roles → "Create Role"
Use case: EKS
Policy: Attach AmazonEKSClusterPolicy
Name: EKSClusterRole
```
```
🔹 EKS Node Group Role:
Go to IAM → Roles → "Create Role"
Use case: EC2 (for nodes)
Policies to Attach:
AmazonEKSWorkerNodePolicy
AmazonEC2ContainerRegistryReadOnly
AmazonEKS_CNI_Policy
```
Name: EKSNodeRole
These roles allow EKS control plane and EC2 nodes to work and talk to other AWS services.

-----
 3. EKS Cluster Setup (via Console)
Amazon EKS (Elastic Kubernetes Service) allows you to deploy, manage, and scale containerized apps using Kubernetes.
🔹 Create Cluster:
Console → EKS → Create Cluster

Fill:
- Cluster Name: llm-cluster
- Kubernetes Version: Choose latest stable
- Cluster Role: Select EKSClusterRole
- VPC: Select llm-vpc
- Subnets: Select the 4 subnets created earlier
- Enable Logging (Optional): Audit logs for debugging


----- 

 4. Node Group Setup (Worker Nodes)

🔹 What are Node Groups?
A node group is a collection of Amazon EC2 instances that EKS uses as worker nodes to run your containerized applications (i.e., the pods in your cluster).

Why Configuring Node Groups is Needed:

-  To Provide Compute Resources
Kubernetes workloads (your LLM app, model server, etc.) run on nodes.
Without node groups, your EKS cluster has no resources to run pods.

-  To Choose Hardware Based on Workload
For LLMs, you need powerful compute — especially GPU-based EC2 instances like g5, p3, or p4d.
Node groups let you select the exact instance type, size, and count suitable for your workload (e.g., g5.xlarge for inference).

-  To Separate Workloads
You can create multiple node groups:
One with GPU instances for model inference
Another with CPU instances for API handling or front-end
This gives better resource isolation, performance, and cost control.

- To Enable Auto Scaling
Node groups allow you to scale your cluster automatically.
Scale up when demand increases (e.g., more LLM queries)
Scale down to save cost during idle times
Use tools like Cluster Autoscaler or Karpenter to automate this.

-  For Managed Operations
When you use Managed Node Groups, AWS:
Automatically handles patching, upgrading, and replacing failed nodes
Simplifies lifecycle management

-  Security and IAM Role Assignment
Each node group gets a node IAM role.
It defines what AWS services your pods can access (e.g., read from S3, write to CloudWatch).

- You can apply different roles to different groups for fine-grained access control.
This is where your application and models run.
```
 Add Node Group:
After cluster is ready → Click "Add Node Group"
```
```
 Node Group Configuration:
Name: llm-node-group
IAM Role: Select EKSNodeRole
Instance Type:
For LLM inference: g4dn.xlarge (has GPU)
For demo/testing: t3.medium (low cost)
Disk: Minimum 20 GiB
Scaling: Min = 1, Max = 2
Networking: Choose private subnets
Security Group: Allow ports like:
22 (SSH)
80 (HTTP)
443 (HTTPS)
3000/5000/8000 (if app-specific)
```

5. Model Storage – Amazon S3
Store your LLM models in S3 buckets for accessibility by EKS pods.
```
🔹 Steps:
Go to AWS Console → S3 → Create Bucket
Name: llm-model-storage
Region: Match with EKS region
Block Public Access: Enabled
Upload: ggml-model.bin or similar model files
```
```
🔹 IAM for S3:
Attach AmazonS3ReadOnlyAccess to EKSNodeRole
Or create custom policy to allow access only to llm-model-storage bucket
```
------
 6. IRSA (IAM Roles for Service Accounts) –
Traditionally, you assign an IAM role to the EC2 instance (i.e., the node) that runs your pods.
This means all pods on that node share the same AWS permissions, which is insecure.

For example:

- If Pod A only needs access to S3, and Pod B needs access to DynamoDB,
- Both will get access to all because they share the node’s IAM role.
- Solution: IAM Roles for Service Accounts (IRSA)
  With IRSA, you attach an IAM role directly to a Kubernetes service account, not the EC2 instance.

This means:
Each pod can assume a unique IAM role with only the permissions it needs.
This follows the principle of least privilege, which is critical for secure cloud deployments.

```
How It Works (Conceptually):
You create a Kubernetes service account
You create an IAM role with a trust policy allowing that service account to assume the role
You annotate the service account with the IAM role ARN
Pods using that service account will get temporary AWS credentials (via STS)
```
This way, pods can securely call:
- Amazon S3 (to read/write model files)
- CloudWatch (to log inference data)
- DynamoDB (for app data)
- Or any other AWS service — but only what it needs.
- Allows Kubernetes pods to use IAM roles securely.
🔹 Purpose:
Instead of giving node-wide permissions, you attach IAM roles to specific pods.
🔹 Steps (Console + CLI):
Enable OIDC Provider in your EKS cluster
Create IAM Role with trust policy for the service account


annotations:
  eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/llm-pod-role
This improves security by granting least privilege access to only required pods.

------
Security groups are like virtual firewalls for your EC2 instances, EKS nodes, load balancers, etc.
They define what kind of traffic is allowed in and out of your resources.
Inbound rules control what type of traffic can enter your AWS resource (e.g., EKS node, application pod, or load balancer).
Outbound rules define what your resource can access outside — like downloading models from S3 or sending logs to CloudWatch.

-----

Why Store LLM Model Artifacts in Amazon S3?
In any production-level LLM deployment, especially on AWS, Amazon S3 (Simple Storage Service) is the standard choice for storing large models, weights, tokenizer files, and any other artifacts.
-  Durability & Reliability
Once your LLM artifacts (e.g., .pt, .bin, .json, .tokenizer) are uploaded, they're safe — even across hardware failures.
-  Scalable Storage for Large Models
LLMs are HUGE – some models are tens or hundreds of GBs.
S3 is infinitely scalable – you never have to worry about outgrowing space.
-  Access Anywhere in AWS
-  Version Control & Backup
S3 supports versioning of files — useful when fine-tuning or updating models.
S3 buckets can be accessed securely from EKS pods, Lambda functions, EC2, etc.
````
# Upload model files to S3
aws s3 cp ./model/ s3://llm-artifacts-bucket/my-model/ --recursive

# EKS pod (with proper IAM role) fetches model
from transformers import AutoModel
model = AutoModel.from_pretrained("s3://llm-artifacts-bucket/my-model/")
```
