####  1. Amazon EKS Cluster
- This is the core of the deployment, providing a managed Kubernetes service that orchestrates your containerized
LLM application.
- A fully managed Kubernetes service running in the private subnet of a VPC.
- Handles orchestration, scaling, and management of containers.

- Contains:
LLM Pod: Runs the large language model (inference code).
App Pod: Interacts with user input and routes it to LLM or AWS APIs.
-----

####  2. EKS Node Group
- A group of EC2 instances (worker nodes).
- May include GPU-enabled EC2 instances (like g4dn.xlarge) for LLM inference performance.

- GPU-enabled EC2 instances are Amazon Elastic Compute Cloud (EC2) instances that include Graphics Processing Units (GPUs).
- Unlike traditional CPUs, GPUs are specialized processors designed for highly parallel computations, making them exceptionally
efficient for workloads that involve complex calculations and require massive throughput.
- This makes them ideal for tasks 
such as Machine Learning (ML) and Deep Learning (DL)

##### Why Configuring Node Groups is Needed:
- Provide Compute Resources
- Choose Hardware: They let you select specific hardware for your workload.
- Enable Auto Scaling: Node groups allow your cluster to scale automatically.
- Security and IAM: Each node group gets its own IAM role, which defines what AWS services the pods running on those nodes can access, enabling fine-grained access control.
 ------

#### Why are GPUs important for LLMs?
LLMs, with their vast number of parameters, require immense computational power for both training and inference. 
GPUs accelerate these processes significantly due to their architecture, which allows them to perform thousands of
operations simultaneously. This parallel processing capability drastically reduces the time needed to train and
run complex AI models compared to CPU-only instances.

- P-series instances: These are the high-performance instances primarily designed for compute-intensive workloads
```
 Examples include P3, P4, and P5 instances. They offer high memory bandwidth.
```
- G-series instances: These are optimized for graphics-intensive applications, media streaming, and lighter 
machine learning inference workloads.
```
Examples include G4dn, G5, and G6 instances. While capable of ML inference, they typically offer a better price-performance 
balance for less demanding GPU tasks compared to the P-series.
```
------

#### 3. VPC (Virtual Private Cloud)
- The entire infrastructure is housed within a VPC, which provides an isolated and secure network environment. 
- Within the VPC, subnets are used to logically segment your network, often separating public-facing resources
from private backend services.
- Includes:
Public Subnet: For services that need internet access (e.g., ALB).
Private Subnet: For sensitive resources like EKS nodes and S3 access.

```
🔹 Step-by-Step:
VPC Dashboard: Go to AWS Console → VPC → "Create VPC"
Name: llm-vpc
CIDR Block: 10.0.0.0/16 – This gives you 65,536 private IPs
Tenancy: Default (shared hardware)
```
```
Create subnets (atleast 2)
Example:
Public Subnet 1: 10.0.1.0/24 (us-east-1a)
Public Subnet 2: 10.0.3.0/24 (us-east-1b)
Private Subnet 1: 10.0.2.0/24 (us-east-1a)
Private Subnet 2: 10.0.4.0/24 (us-east-1b)
```
```
Internet Gateway:
Used to provide internet access to public subnets.
After creation, attach it to the VPC. 🔹 Route Table:
For public subnets: Create a route table → Add route 0.0.0.0/0 → Target = Internet Gateway → Associate to public subnets.
```
------

#### 4. IAM Roles & IRSA (IAM Roles for Service Accounts)
- Secure way for pods in EKS to access AWS services.
- This means your LLM application pods can securely access other AWS services (like S3 for model storage) without needing
to embed AWS credentials directly within the pod.
```
Example:
LLM pod → can read model from S3 using assigned IAM role.
App pod → can use Boto3 SDK to access Lambda, EC2, etc.
```
- Defined Policies: IAM policies are created to control access to various AWS resources, ensuring that only authorized 
components can interact with services like EKS, S3 (for model storage), EC2, CloudWatch, and Lambda.

 IRSA (IAM Roles for Service Accounts) – Traditionally, you assign an IAM role to the EC2 instance (i.e., the node) that runs your pods. This means all pods on that node share the same AWS permissions, which is insecure.
For example:

If Pod A only needs access to S3, and Pod B needs access to DynamoDB,
Both will get access to all because they share the node’s IAM role.
Solution: IAM Roles for Service Accounts (IRSA) With IRSA, you attach an IAM role directly to a Kubernetes service account, not the EC2 instance.
This means: Each pod can assume a unique IAM role with only the permissions it needs. This follows the principle of least privilege, which is critical for secure cloud deployments.

```
How It Works (Conceptually):
You create a Kubernetes service account
You create an IAM role with a trust policy allowing that service account to assume the role
You annotate the service account with the IAM role ARN
Pods using that service account will get temporary AWS credentials (via STS)

```
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
```
Create Cluster: Console → EKS → Create Cluster
Fill:
Cluster Name: llm-cluster
Kubernetes Version: Choose latest stable
Cluster Role: Select EKSClusterRole
VPC: Select llm-vpc
Subnets: Select the 4 subnets created earlier
Enable Logging (Optional): Audit logs for debugging
```

------
####  5. S3 Bucket
- LLM model artifacts (the trained model files) are securely stored in an Amazon S3 bucket.
- EKS pods, leveraging IRSA, can then securely retrieve these model artifacts for deployment and inference.
- Used for storing:
Pre-trained or fine-tuned LLM model weights.
Processed training data or logs if needed.

##### Why Store LLM Model Artifacts in Amazon S3?
- Durability & Reliability Once your LLM artifacts (e.g., .pt, .bin, .json, .tokenizer) are uploaded, they're safe — even across hardware failures.
- Scalable Storage for Large Models LLMs are HUGE – some models are tens or hundreds of GBs. S3 is infinitely scalable – you never have to worry about outgrowing space.
- Access Anywhere in AWS
- Version Control & Backup S3 supports versioning of files — useful when fine-tuning or updating models. S3 buckets can be accessed securely from EKS pods, Lambda functions, EC2, etc.

```
# Upload model files to S3
aws s3 cp ./model/ s3://llm-artifacts-bucket/my-model/ --recursive

# EKS pod (with proper IAM role) fetches model
from transformers import AutoModel
model = AutoModel.from_pretrained("s3://llm-artifacts-bucket/my-model/")
``` 
------

#### 6. Security Groups
- These act as virtual firewalls at the instance level, controlling inbound and outbound network traffic EKS nodes and 
the application pods running your LLM.
- They ensure that only necessary traffic can reach your components.
- Allow traffic between pods, load balancer, and external users.

-----

#### 7. Route Tables
- Determine how traffic flows between public and private subnets.
- Ensure only required traffic reaches sensitive nodes in private subnet.
-----

#### 8. Application Load Balancer (ALB)
- Sits in the public subnet.
- Routes incoming HTTP(S) traffic to the right Kubernetes service (e.g., app pod).
- Enables external access to the app frontend or API.

###  Why LLM Deployment is Different

#### 1. Massive GPU Compute
- CPUs cannot efficiently perform transformer-based inference.
- GPU instances (e.g., g5, p4d, p5) are mandatory for real-time LLMs.

#### 2. Token-Based Processing
- LLMs use tokenized inputs and outputs.
- Requires frameworks like HuggingFace Transformers, vLLM, TGI.

#### 3. Large Model Loading
- LLMs can take minutes to load into memory.
- Fast I/O from S3 or FSx is needed to handle large weights.

#### 4. High Memory Usage
- Some models use up to 80 GB VRAM.
- Models often need to be quantized or sharded.

#####  Special AWS Services for LLM Deployment

| Service | Purpose |
|---------|---------|
| **Amazon S3** | Store large model files |
| **Amazon FSx for Lustre** | High-throughput model access |
| **Amazon SageMaker** | Managed GPU training and inference |
| **Amazon EKS + GPU Nodes** | Host custom LLM inference workloads |
| **EFA (Elastic Fabric Adapter)** | High-speed network for multi-GPU training |
| **AWS Batch or Async Lambda** | Delayed inference |
| **Bedrock** | Use commercial LLMs without hosting |
| **Prometheus + Grafana** | GPU monitoring |
| **IRSA (IAM Roles for Service Accounts)** | Secure pod-level AWS access |
