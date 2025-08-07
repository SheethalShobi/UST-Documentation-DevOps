
# AWS Infrastructure for LLM Deployment

Deploying a large language model (LLM) and its applications on AWS requires a well-architected infrastructure that is robust, scalable, and secure. A common and highly flexible approach is to use **Amazon EKS (Elastic Kubernetes Service)** to manage the containerized applications, as it provides a powerful platform for orchestrating and scaling resources, especially those with specialized hardware like GPUs.

---

## 1. Amazon EKS Cluster Provisioning

An EKS cluster is the core of your infrastructure. It provides the control plane for your Kubernetes environment.

### Creating an EKS cluster

You can use either:
- **eksctl** (preferred for Infrastructure as Code)
- **AWS Console** (preferred for hands-on GUI)

#### eksctl
`eksctl` is a command-line tool to simplify EKS cluster creation. It allows:
- Reusable YAML configurations
- Version control of infra
- Quick and consistent provisioning

#### AWS Console
- GUI-based cluster creation for beginners or exploration.
- Helpful to understand the components visually.

### Configuring Node Groups (with GPU support)

LLMs need powerful compute (GPUs) for inference.

- Use **GPU-optimized EC2 instances** (e.g., `g5`, `p4d`)
- Prefer **Managed Node Groups (MNGs)** for ease of updates and scaling

#### Autoscaling Nodes
Use tools like:
- **Karpenter** or
- **Cluster Autoscaler**

To:
- Scale up when workloads increase
- Save cost by scaling down idle GPU nodes

---

## 2. Identity and Access Management (IAM)

IAM controls access across AWS.

### IAM Roles for Service Accounts (IRSA)

IRSA allows Pods to assume specific IAM roles instead of giving all permissions to the EC2 node.

- Enhances security with least privilege
- Pod uses a **service account** that maps to an IAM role

### Defining IAM Policies

Attach only necessary permissions to your LLM components:

- **Amazon S3**: Read/write model data or logs
- **CloudWatch**: Log metrics and inference stats
- **DynamoDB/RDS**: Database access for metadata or outputs
- **Lambda**: For async post-processing functions

---

## 3. Networking

Networking is crucial for security and accessibility.

### VPC Design

- Use both **Public** and **Private subnets**
  - **Public Subnets**: Load Balancers, NAT Gateway
  - **Private Subnets**: GPU-based EKS worker nodes

### Routing Tables

- Private subnets → NAT Gateway (outbound access only)
- Public subnets → Internet Gateway (inbound/outbound)

### Security Groups

- **EKS Nodes**: Allow traffic only from trusted sources (LB, cluster)
- **Load Balancers**: Allow 443 (HTTPS) for app access

### VPC Endpoints

Use VPC Endpoints for private communication with AWS services like S3, DynamoDB:
- No internet exposure
- Traffic stays within AWS

---

This infrastructure enables **secure, scalable, cost-effective** deployment of large-scale LLM applications.

##  Key Differences: LLM Deployment vs Normal Deployment

| Aspect | Normal Web/App Deployment | LLM Deployment |
|--------|----------------------------|----------------|
| **Compute Requirements** | CPU or small EC2 instances (e.g., t2.micro, t3.medium) | High-end GPU instances (e.g., `g5`, `p4d`, `p5`) |
| **Memory (RAM)** | 1–8 GB RAM is usually enough | 40 GB+ RAM needed (LLMs are huge!) |
| **Model Size** | <100 MB (typical ML models) | 5 GB – 200+ GB (LLaMA, Falcon, GPT-J, etc.) |
| **Latency Sensitivity** | Lower importance | Low-latency critical (users expect quick replies) |
| **Storage Requirements** | Mostly for DB and logs | S3/FSx needed to store large model binaries |
| **Scaling** | Auto scaling of stateless apps | GPU autoscaling is complex and expensive |
| **Deployment Platform** | ECS, EC2, Lambda, or EKS | Mostly EC2 with GPU, SageMaker, or EKS with GPUs |
| **Inference Framework** | Flask, FastAPI, simple REST apps | TGI, vLLM, DeepSpeed, or custom inference servers |
| **Security** | Focused on API keys, IAM | Data privacy + memory isolation + token safety |
| **Cost** | Low to moderate | Very high ($$$/hour for GPUs) |

---

##  Why LLM Deployment is Different

### 1. Massive GPU Compute
- CPUs cannot efficiently perform transformer-based inference.
- GPU instances (e.g., g5, p4d, p5) are mandatory for real-time LLMs.

### 2. Token-Based Processing
- LLMs use tokenized inputs and outputs.
- Requires frameworks like HuggingFace Transformers, vLLM, TGI.

### 3. Large Model Loading
- LLMs can take minutes to load into memory.
- Fast I/O from S3 or FSx is needed to handle large weights.

### 4. High Memory Usage
- Some models use up to 80 GB VRAM.
- Models often need to be quantized or sharded.

### 5. Inference Optimization Tools
- **vLLM**: Optimized inference engine with PagedAttention.
- **TGI**: Text Generation Inference from HuggingFace.
- **DeepSpeed**: Distributed inference support.

### 6. GPU-aware Autoscaling
- LLMs are stateful and GPU-bound.
- Use Cluster Autoscaler or Karpenter with taints/tolerations in EKS.

---

## 🛠️ Special AWS Services for LLM Deployment

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

---
