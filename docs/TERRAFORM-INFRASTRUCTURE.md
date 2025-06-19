# Terraform Infrastructure Documentation

## Overview

This document provides detailed explanations for all Terraform infrastructure components used in the ITI E-Commerce Platform project.

## File Structure

```
Terraform/
├── main.tf                    # Main infrastructure orchestration
├── variables.tf               # Input variables definition
├── terraform.tfvars          # Environment-specific values
├── Provider_init.tf           # AWS provider configuration
├── Inventory_Output.tf        # Ansible inventory generation
└── Modules/                   # Reusable infrastructure modules
    ├── Network_Module/
    ├── Jenkins_EC2_Module/
    ├── EKS_Cluster_Module/
    ├── ECR_Module/
    ├── S3_Logs_Module/
    └── Aws_Backup_Module/
```

## Core Files

### main.tf
**Purpose**: Main infrastructure orchestration file that brings together all modules.

**Contents**:
- Module declarations for all infrastructure components
- Resource dependencies and relationships
- Output definitions for cross-module communication

**Key Resources**:
```hcl
module "Network_Module" {
  source = "./Modules/Network_Module"
  # Network configuration parameters
}

module "EKS_Cluster_Module" {
  source = "./Modules/EKS_Cluster_Module"
  # EKS cluster configuration
}
```

### variables.tf
**Purpose**: Defines all input variables used across the infrastructure.

**Variable Categories**:
- **AWS Configuration**: Region, availability zones
- **Network Settings**: VPC CIDR, subnet configurations
- **Instance Settings**: EC2 instance types, key pairs
- **EKS Configuration**: Cluster version, node group settings
- **Security Settings**: Security group rules, IAM policies

**Example Variables**:
```hcl
variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
```

### terraform.tfvars
**Purpose**: Contains actual values for variables (environment-specific).

**Security Note**: This file contains sensitive information and should be handled carefully.

**Contents**:
- AWS credentials or profile configuration
- Environment-specific values
- Instance sizing and scaling parameters

### Provider_init.tf
**Purpose**: Configures the AWS provider and backend settings.

**Contents**:
- AWS provider configuration
- Backend configuration for state management
- Required provider versions

**Example Configuration**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

### Inventory_Output.tf
**Purpose**: Generates Ansible inventory file from Terraform outputs.

**Functionality**:
- Extracts EC2 instance information
- Creates dynamic inventory for Ansible
- Includes instance IPs, hostnames, and metadata

## Modules Documentation

### Network_Module
**Purpose**: Creates the foundational network infrastructure.

**Components**:
- **VPC**: Virtual Private Cloud with custom CIDR
- **Subnets**: Public and private subnets across multiple AZs
- **Internet Gateway**: Internet access for public subnets
- **NAT Gateway**: Outbound internet access for private subnets
- **Route Tables**: Routing configuration for subnets
- **Security Groups**: Network-level security rules

**Key Files**:
- `main.tf`: Network resource definitions
- `variables.tf`: Network-specific variables
- `outputs.tf`: Network resource outputs

### Jenkins_EC2_Module
**Purpose**: Provisions Jenkins CI/CD server infrastructure.

**Components**:
- **EC2 Instance**: Jenkins server with appropriate sizing
- **Security Group**: Jenkins-specific security rules
- **IAM Role**: Permissions for Jenkins operations
- **Key Pair**: SSH access configuration
- **Elastic IP**: Static IP for Jenkins server

**Security Features**:
- Restricted SSH access
- HTTPS configuration
- IAM role-based permissions
- Security group rules for CI/CD operations

### EKS_Cluster_Module
**Purpose**: Creates managed Kubernetes cluster infrastructure.

**Components**:
- **EKS Cluster**: Managed Kubernetes control plane
- **Node Groups**: Worker node configurations
- **IAM Roles**: Cluster and node group permissions
- **Security Groups**: Cluster networking security
- **Add-ons**: Essential EKS add-ons (VPC CNI, CoreDNS)

**Configuration Options**:
- Node instance types and scaling
- Kubernetes version management
- Subnet placement for high availability
- Security and access controls

### ECR_Module
**Purpose**: Container registry for application images.

**Components**:
- **ECR Repositories**: Private container registries
- **Lifecycle Policies**: Image retention management
- **IAM Policies**: Repository access permissions
- **Repository Policies**: Cross-account access if needed

**Features**:
- Image scanning for vulnerabilities
- Encryption at rest
- Lifecycle management for cost optimization

### S3_Logs_Module
**Purpose**: Centralized logging and storage solution.

**Components**:
- **S3 Buckets**: Log storage with appropriate configurations
- **Bucket Policies**: Access control for log data
- **Lifecycle Rules**: Log retention and archival
- **Encryption**: Server-side encryption for security

**Use Cases**:
- Application logs storage
- Infrastructure logs archival
- Backup storage
- Static asset hosting

### Aws_Backup_Module
**Purpose**: Automated backup and disaster recovery.

**Components**:
- **Backup Vault**: Secure backup storage
- **Backup Plans**: Automated backup schedules
- **IAM Roles**: Backup service permissions
- **Recovery Points**: Point-in-time recovery options

**Backup Strategies**:
- Daily incremental backups
- Weekly full backups
- Cross-region backup replication
- Automated retention policies

## Deployment Process

### 1. Prerequisites
```bash
# Install Terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Configure AWS credentials
aws configure
```

### 2. Infrastructure Deployment
```bash
# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply infrastructure
terraform apply
```

### 3. Verification
```bash
# Check infrastructure status
terraform show

# Verify outputs
terraform output

# Validate AWS resources
aws eks list-clusters
aws ec2 describe-instances
```

## Best Practices

### Security
- Use IAM roles instead of access keys
- Enable encryption for all storage
- Implement least privilege access
- Regular security group audits

### Cost Optimization
- Use appropriate instance types
- Implement auto-scaling
- Set up lifecycle policies
- Monitor and optimize regularly

### Maintenance
- Regular Terraform state backups
- Module version management
- Infrastructure documentation updates
- Disaster recovery testing

## Troubleshooting

### Common Issues
1. **Permission Errors**: Check IAM policies and roles
2. **Resource Limits**: Verify AWS service quotas
3. **Network Issues**: Check security groups and NACLs
4. **State Lock Issues**: Verify backend configuration

### Debugging Commands
```bash
# Detailed logging
export TF_LOG=DEBUG
terraform apply

# State inspection
terraform state list
terraform state show <resource>

# Resource refresh
terraform refresh
```

## Monitoring and Maintenance

### Infrastructure Monitoring
- CloudWatch metrics for all resources
- AWS Config for compliance monitoring
- CloudTrail for audit logging
- Cost and usage monitoring

### Regular Maintenance Tasks
- Terraform state file backups
- Security updates and patches
- Resource utilization reviews
- Cost optimization analysis

---

For more information, see:
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [Project README](../README.md)
