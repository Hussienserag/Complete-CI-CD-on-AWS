# Comprehensive Terraform Outputs
# This file consolidates all outputs and saves them to files for easy access

# Main Infrastructure Outputs
output "jenkins_public_ip" {
  description = "Public IP of Jenkins EC2 instance"
  value       = module.Jenkin_EC2_Module.Jenkins_public_ip
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.Eks_Cluster_Module.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.Eks_Cluster_Module.cluster_endpoint
}

output "ecr_frontend_repository" {
  description = "ECR frontend repository URL"
  value       = module.ECR_Module.frontend_repository_url
}

output "ecr_backend_repository" {
  description = "ECR backend repository URL"
  value       = module.ECR_Module.backend_repository_url
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.Network_Module.vpc_id
}

# Jenkins IAM and Access Outputs
output "jenkins_iam_role_arn" {
  description = "ARN of Jenkins IAM role with ECR, EKS, S3 access"
  value       = module.Jenkin_EC2_Module.jenkins_iam_role_arn
}

output "jenkins_iam_role_name" {
  description = "Name of Jenkins IAM role"
  value       = module.Jenkin_EC2_Module.jenkins_iam_role_name
}

output "jenkins_instance_profile_arn" {
  description = "ARN of Jenkins instance profile"
  value       = module.Jenkin_EC2_Module.jenkins_instance_profile_arn
}

output "jenkins_custom_policies" {
  description = "Custom IAM policies created for Jenkins"
  value       = module.Jenkin_EC2_Module.jenkins_custom_policies
}

output "jenkins_ssh_command" {
  description = "SSH command to access Jenkins instance"
  value       = "ssh -i ${module.Jenkin_EC2_Module.jenkins_private_key_path} ec2-user@${module.Jenkin_EC2_Module.Jenkins_public_ip}"
}

# Save outputs to files using local_file resources
resource "local_file" "terraform_outputs" {
  filename = "../outputs/terraform-outputs.json"
  content = jsonencode({
    jenkins = {
      public_ip = module.Jenkin_EC2_Module.Jenkins_public_ip
      instance_id = module.Jenkin_EC2_Module.EC2_Jenkins_id
      ssh_command = "ssh -i ${module.Jenkin_EC2_Module.jenkins_private_key_path} ec2-user@${module.Jenkin_EC2_Module.Jenkins_public_ip}"
      iam_role_arn = module.Jenkin_EC2_Module.jenkins_iam_role_arn
      iam_role_name = module.Jenkin_EC2_Module.jenkins_iam_role_name
      private_key_path = module.Jenkin_EC2_Module.jenkins_private_key_path
      public_key_path = module.Jenkin_EC2_Module.jenkins_public_key_path
    }
    eks = {
      cluster_name = module.Eks_Cluster_Module.cluster_name
      cluster_endpoint = module.Eks_Cluster_Module.cluster_endpoint
    }
    ecr = {
      frontend_repository = module.ECR_Module.frontend_repository_url
      backend_repository = module.ECR_Module.backend_repository_url
    }
    network = {
      vpc_id = module.Network_Module.vpc_id
      public_subnet1_id = module.Network_Module.Public_Subnet1_id
      public_subnet2_id = module.Network_Module.Public_Subnet2_id
    }
    timestamp = timestamp()
  })
}

# Jenkins access information
resource "local_file" "jenkins_access" {
  filename = "../outputs/jenkins-access.txt"
  content = <<EOF
Jenkins Access Information
==========================
Public IP: ${module.Jenkin_EC2_Module.Jenkins_public_ip}
Instance ID: ${module.Jenkin_EC2_Module.EC2_Jenkins_id}
SSH Command: ssh -i ${module.Jenkin_EC2_Module.jenkins_private_key_path} ec2-user@${module.Jenkin_EC2_Module.Jenkins_public_ip}
Jenkins URL: http://${module.Jenkin_EC2_Module.Jenkins_public_ip}:8080
IAM Role ARN: ${module.Jenkin_EC2_Module.jenkins_iam_role_arn}
Private Key Path: ${module.Jenkin_EC2_Module.jenkins_private_key_path}
Public Key Path: ${module.Jenkin_EC2_Module.jenkins_public_key_path}

Generated at: ${timestamp()}
EOF
}

# EKS cluster information
resource "local_file" "eks_info" {
  filename = "../outputs/eks-cluster-info.txt"
  content = <<EOF
EKS Cluster Information
=======================
Cluster Name: ${module.Eks_Cluster_Module.cluster_name}
Cluster Endpoint: ${module.Eks_Cluster_Module.cluster_endpoint}

kubectl Configuration:
aws eks update-kubeconfig --region us-east-1 --name ${module.Eks_Cluster_Module.cluster_name}

Generated at: ${timestamp()}
EOF
}

# ECR repositories information
resource "local_file" "ecr_info" {
  filename = "../outputs/ecr-repositories.txt"
  content = <<EOF
ECR Repositories Information
============================
Frontend Repository: ${module.ECR_Module.frontend_repository_url}
Backend Repository: ${module.ECR_Module.backend_repository_url}

Docker Login Command:
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${module.ECR_Module.frontend_repository_url}

Generated at: ${timestamp()}
EOF
}

# Environment variables file for CI/CD
resource "local_file" "env_vars" {
  filename = "../outputs/environment-variables.env"
  content = <<EOF
# Terraform Generated Environment Variables
JENKINS_PUBLIC_IP=${module.Jenkin_EC2_Module.Jenkins_public_ip}
JENKINS_INSTANCE_ID=${module.Jenkin_EC2_Module.EC2_Jenkins_id}
EKS_CLUSTER_NAME=${module.Eks_Cluster_Module.cluster_name}
EKS_CLUSTER_ENDPOINT=${module.Eks_Cluster_Module.cluster_endpoint}
ECR_FRONTEND_REPO=${module.ECR_Module.frontend_repository_url}
ECR_BACKEND_REPO=${module.ECR_Module.backend_repository_url}
VPC_ID=${module.Network_Module.vpc_id}
JENKINS_IAM_ROLE_ARN=${module.Jenkin_EC2_Module.jenkins_iam_role_arn}
AWS_REGION=us-east-1
EOF
}

# Kubernetes deployment variables
resource "local_file" "k8s_vars" {
  filename = "../outputs/k8s-deployment-vars.yaml"
  content = <<EOF
# Kubernetes Deployment Variables
apiVersion: v1
kind: ConfigMap
metadata:
  name: terraform-outputs
  namespace: default
data:
  jenkins-ip: "${module.Jenkin_EC2_Module.Jenkins_public_ip}"
  eks-cluster-name: "${module.Eks_Cluster_Module.cluster_name}"
  eks-cluster-endpoint: "${module.Eks_Cluster_Module.cluster_endpoint}"
  ecr-frontend-repo: "${module.ECR_Module.frontend_repository_url}"
  ecr-backend-repo: "${module.ECR_Module.backend_repository_url}"
  vpc-id: "${module.Network_Module.vpc_id}"
  generated-at: "${timestamp()}"
EOF
}

# Shell script for easy environment setup
resource "local_file" "setup_script" {
  filename = "../outputs/setup-environment.sh"
  file_permission = "0755"
  content = <<EOF
#!/bin/bash
# Terraform Generated Environment Setup Script

echo "Setting up environment with Terraform outputs..."

# Export environment variables
export JENKINS_PUBLIC_IP="${module.Jenkin_EC2_Module.Jenkins_public_ip}"
export JENKINS_INSTANCE_ID="${module.Jenkin_EC2_Module.EC2_Jenkins_id}"
export EKS_CLUSTER_NAME="${module.Eks_Cluster_Module.cluster_name}"
export EKS_CLUSTER_ENDPOINT="${module.Eks_Cluster_Module.cluster_endpoint}"
export ECR_FRONTEND_REPO="${module.ECR_Module.frontend_repository_url}"
export ECR_BACKEND_REPO="${module.ECR_Module.backend_repository_url}"
export VPC_ID="${module.Network_Module.vpc_id}"
export AWS_REGION="us-east-1"

echo "Environment variables set successfully!"
echo "Jenkins URL: http://$JENKINS_PUBLIC_IP:8080"
echo "EKS Cluster: $EKS_CLUSTER_NAME"

# Configure kubectl for EKS
echo "Configuring kubectl for EKS cluster..."
aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER_NAME

# Login to ECR
echo "Logging into ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_FRONTEND_REPO

echo "Setup complete!"
EOF
}
