# 🚀 ITI DevOps Infrastructure Deployment Guide

This guide provides step-by-step instructions for deploying the complete ITI e-commerce DevOps infrastructure.

## 📋 Prerequisites

Before running the deployment, ensure you have the following tools installed:

### Required Tools
- **Terraform** (>= 1.0)
- **Ansible** (>= 2.9)
- **AWS CLI** (>= 2.0)
- **kubectl** (>= 1.21)

### Installation Commands

```bash
# Install Terraform (Ubuntu/Debian)
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install Ansible
sudo apt update && sudo apt install ansible

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## 🔧 Configuration

### 1. AWS Credentials
Configure your AWS credentials:
```bash
aws configure
```

### 2. Terraform Variables
The `terraform.tfvars` file is already configured with default values:
```hcl
cidr_blocks = {
  vpc_cidr               = "10.0.0.0/16"
  public_subnet1_cidr    = "10.0.0.0/24"
  public_subnet2_cidr    = "10.0.2.0/24"
  private_subnet1_cidr   = "10.0.3.0/24"
  private_subnet2_cidr   = "10.0.4.0/24"
}
Availabillity_Zones = ["us-east-1a", "us-east-1b"]
```

## 🚀 Deployment

### Automated Deployment
Run the automated deployment script:
```bash
./deploy-infrastructure.sh
```

This script will:
1. ✅ Check prerequisites
2. ✅ Validate AWS credentials
3. ✅ Deploy infrastructure with Terraform
4. ✅ Configure servers with Ansible
5. ✅ Configure kubectl for EKS
6. ✅ Display deployment information

### Manual Deployment (if needed)

#### Step 1: Deploy Infrastructure
```bash
cd Terraform
terraform init
terraform plan
terraform apply
```

#### Step 2: Configure Servers
```bash
cd ../Ansible
ansible-playbook -i my_inventory.ini roles_playbook.yml --private-key ../Terraform/Modules/Jenkins_EC2_Module/Project_Keys/jenkins.pem
```

#### Step 3: Configure kubectl
```bash
aws eks update-kubeconfig --region us-east-1 --name <cluster-name>
kubectl get nodes
```

## 📊 What Gets Deployed

### Infrastructure Components
- **VPC** with public and private subnets across 2 AZs
- **Jenkins EC2** instance with public IP
- **EKS Cluster** with 3 worker nodes (t2.large)
- **Public ECR** repositories for frontend and backend
- **CloudWatch** monitoring and dashboards
- **Security Groups** with appropriate rules

### Software Installation (via Ansible)
- **Jenkins** - CI/CD server
- **Docker** - Container runtime
- **CloudWatch Agent** - System monitoring
- **Trivy** - Security vulnerability scanner

## 📋 Post-Deployment Steps

### 1. Access Jenkins
- URL: `http://<jenkins-public-ip>:8080`
- Get initial admin password:
  ```bash
  ssh -i Terraform/Modules/Jenkins_EC2_Module/Project_Keys/jenkins.pem ec2-user@<jenkins-ip>
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```

### 2. Configure Jenkins
1. Install suggested plugins
2. Create admin user
3. Install additional plugins:
   - Docker Pipeline
   - Kubernetes
   - AWS Steps
   - AnsiColor

### 3. Deploy Applications
```bash
# Navigate to k8s directory
cd k8s

# Deploy the application
./deploy.sh
```

## 🔍 Monitoring

### CloudWatch Dashboard
Access your monitoring dashboard at the URL provided in the deployment output.

### Useful Commands
```bash
# Check EKS nodes
kubectl get nodes

# Check running pods
kubectl get pods -n ecommerce

# View Jenkins logs
ssh -i <key-file> ec2-user@<jenkins-ip>
sudo journalctl -u jenkins -f

# Check CloudWatch agent status
sudo systemctl status amazon-cloudwatch-agent
```

## 🧹 Cleanup

To destroy all infrastructure:
```bash
./destroy-infrastructure.sh
```

**⚠️ Warning**: This will delete ALL resources and data!

## 🔧 Troubleshooting

### Common Issues

#### 1. Permission Denied for SSH Key
```bash
chmod 400 Terraform/Modules/Jenkins_EC2_Module/Project_Keys/jenkins.pem
```

#### 2. Ansible Connection Issues
Wait 2-3 minutes after EC2 deployment before running Ansible.

#### 3. kubectl Connection Issues
```bash
aws eks update-kubeconfig --region us-east-1 --name <cluster-name> --profile <your-profile>
```

#### 4. ECR Push Issues
```bash
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

## 📊 Cost Estimation

### Monthly Costs (us-east-1)
- **EC2 t2.medium (Jenkins)**: ~$33.87
- **EKS Cluster**: $73.00
- **EC2 t2.large x3 (EKS nodes)**: ~$201.56
- **Data Transfer & Storage**: ~$20-50

**Total Estimated**: ~$328-358/month

### Cost Optimization Tips
- Use Spot Instances for EKS nodes
- Schedule EKS node groups to scale down during off-hours
- Use smaller instance types for development

## 📞 Support

For issues related to this deployment:
1. Check the troubleshooting section above
2. Review AWS CloudWatch logs
3. Check Terraform state for resource status
4. Verify AWS service limits

## 📝 Notes

- Default region: `us-east-1`
- EKS cluster includes 3 worker nodes for high availability
- All resources are tagged for easy identification
- Security groups follow least privilege principle
- CloudWatch monitoring is pre-configured
