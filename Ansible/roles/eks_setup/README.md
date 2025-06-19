# EKS Setup Role

This Ansible role sets up an EKS cluster with essential tools and services.

## What it installs:

1. **kubectl** - Kubernetes command-line tool
2. **Helm** - Kubernetes package manager
3. **NGINX Ingress Controller** - Load balancer and ingress controller
4. **ArgoCD** - GitOps continuous delivery tool

## Components Configured:

### NGINX Ingress Controller
- Deployed in `ingress-nginx` namespace
- Configured with LoadBalancer service type
- Metrics enabled for monitoring

### ArgoCD
- Deployed in `argocd` namespace
- Web UI accessible via LoadBalancer
- Insecure mode enabled for easy access
- Initial admin password automatically retrieved

## Usage:

The role is automatically included in the main playbook and will:
1. Install all required tools
2. Configure kubectl to connect to your EKS cluster
3. Install and configure all services
4. Provide access information for ArgoCD and Ingress

## Access Information:

After deployment, check `/tmp/eks_setup_summary.txt` for:
- ArgoCD URL and credentials
- NGINX Ingress LoadBalancer endpoint
- Useful kubectl commands

## Requirements:

- EKS cluster must be running
- AWS CLI configured with appropriate permissions
- Ansible control node with internet access
