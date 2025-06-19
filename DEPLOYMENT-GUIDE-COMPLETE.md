# 🚀 Complete EKS Deployment Guide

This guide provides everything you need to deploy a complete e-commerce application on AWS EKS.

## 📋 Prerequisites

### Required Tools
- **AWS CLI v2** - Configure with `aws configure`
- **Terraform** - For infrastructure deployment
- **kubectl** - For Kubernetes management
- **Docker** - For container operations
- **Helm** (optional) - For package management

### AWS Permissions
Your AWS user/role needs permissions for:
- EKS (full access)
- EC2 (VPC, Security Groups, Instances)
- IAM (roles, policies)
- Application Load Balancer
- EBS (for persistent storage)

## 🎯 Quick Start

### Option 1: Complete Infrastructure + Application (Recommended)
Deploy everything from scratch:

```bash
# Clone and navigate to project
cd ITI-Project

# Deploy complete infrastructure and application
./deploy-complete-infrastructure.sh
```

This script will:
1. ✅ Check all prerequisites
2. 🏗️ Deploy infrastructure with Terraform
3. ⚙️ Configure kubectl for EKS
4. ⏳ Wait for cluster to be ready
5. 🚀 Deploy the e-commerce application
6. 🔍 Run health checks
7. 📋 Generate deployment summary

### Option 2: Application Only (EKS cluster exists)
If you already have an EKS cluster running:

```bash
# Navigate to k8s directory
cd k8s

# Configure kubectl for your cluster
aws eks update-kubeconfig --region us-east-1 --name your-cluster-name

# Deploy application
./deploy-eks-optimized.sh
```

## 📁 Project Structure

```
ITI-Project/
├── deploy-complete-infrastructure.sh   # Complete deployment script
├── Terraform/                          # Infrastructure code
│   ├── main.tf                        # Main Terraform configuration
│   ├── outputs.tf                     # Output definitions
│   └── Modules/                       # Terraform modules
├── k8s/                               # Kubernetes manifests
│   ├── deploy-eks-optimized.sh        # Application deployment script
│   ├── 00-namespace.yaml              # Namespace definition
│   ├── 01-configmap-secret.yaml       # Configuration
│   ├── 02-mongodb.yaml                # Database
│   ├── 03-backend.yaml                # API service
│   ├── 04-frontend.yaml               # Web application
│   ├── 05-ingress.yaml                # Ingress controller
│   ├── 06-monitoring.yaml             # Monitoring stack
│   ├── 07-seed-job.yaml               # Initial data
│   └── 08-loadbalancer-services.yaml  # LoadBalancer services
└── outputs/                           # Generated files
    ├── deployment-summary.md           # Complete deployment info
    ├── eks-deployment-info.txt         # Access URLs and commands
    └── check-eks-status.sh             # Status monitoring script
```

## 🔧 What Gets Deployed

### Infrastructure (Terraform)
- **EKS Cluster** - Managed Kubernetes cluster
- **VPC & Networking** - Subnets, security groups, routing
- **IAM Roles** - Service accounts and permissions
- **Worker Nodes** - EC2 instances for application workloads
- **Load Balancers** - Application Load Balancer (ALB)

### Application (Kubernetes)
- **MongoDB** - Database with persistent storage
- **Backend API** - Node.js/Express API server
- **Frontend** - React web application
- **Ingress** - Traffic routing and SSL termination
- **LoadBalancer Services** - Direct external access
- **Monitoring** - Prometheus (optional)
- **Seed Job** - Initial product data

## 🌐 Access Your Application

After deployment, you'll have multiple access methods:

### 1. Direct LoadBalancer Access
```bash
# Frontend application
http://<frontend-lb-hostname>

# Backend API
http://<backend-lb-hostname>/api/health
http://<backend-lb-hostname>/api/products
```

### 2. Ingress (Application Load Balancer)
```bash
# Unified access through ALB
http://<alb-hostname>          # Frontend
http://<alb-hostname>/api      # Backend API
```

### 3. Get Access URLs
```bash
# Check LoadBalancer services
kubectl get svc -n ecommerce --field-selector spec.type=LoadBalancer

# Check ingress
kubectl get ingress -n ecommerce

# Or use the status checker
./outputs/check-eks-status.sh
```

## 📊 Monitoring and Management

### Check Application Status
```bash
# Quick status check
./outputs/check-eks-status.sh

# Detailed view
kubectl get all -n ecommerce
kubectl get pods -n ecommerce -o wide
```

### View Logs
```bash
# Frontend logs
kubectl logs -f deployment/frontend-deployment -n ecommerce

# Backend logs
kubectl logs -f deployment/backend-deployment -n ecommerce

# Database logs
kubectl logs -f deployment/mongodb-deployment -n ecommerce
```

### Scaling
```bash
# Scale frontend
kubectl scale deployment frontend-deployment --replicas=3 -n ecommerce

# Scale backend
kubectl scale deployment backend-deployment --replicas=2 -n ecommerce
```

## 🔍 Troubleshooting

### Common Issues

#### 1. LoadBalancers Stuck in Pending
```bash
# Check AWS Load Balancer Controller
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller

# Check events
kubectl get events -n ecommerce --sort-by='.lastTimestamp'
```

#### 2. Pods Not Starting
```bash
# Describe problematic pods
kubectl describe pod <pod-name> -n ecommerce

# Check resource constraints
kubectl top nodes
kubectl top pods -n ecommerce
```

#### 3. Database Connection Issues
```bash
# Test MongoDB connectivity
kubectl exec -n ecommerce deployment/mongodb-deployment -- mongosh --eval "db.adminCommand('ping')"

# Check persistent volume
kubectl get pv,pvc -n ecommerce
```

#### 4. External Access Not Working
```bash
# Verify security groups allow traffic
aws ec2 describe-security-groups --region us-east-1

# Check ingress configuration
kubectl describe ingress -n ecommerce

# Verify ALB provisioning
aws elbv2 describe-load-balancers --region us-east-1
```

### Debug Commands
```bash
# Get all events
kubectl get events --all-namespaces --sort-by='.lastTimestamp'

# Check cluster health
kubectl cluster-info dump

# View cluster configuration
kubectl config view

# Check node resources
kubectl describe nodes
```

## 🧹 Cleanup

### Remove Application Only
```bash
kubectl delete namespace ecommerce
```

### Complete Infrastructure Cleanup
```bash
# Remove application first
kubectl delete namespace ecommerce

# Destroy infrastructure
cd Terraform
terraform destroy --auto-approve
```

### Force Cleanup (if resources are stuck)
```bash
# Use the cleanup script
./cleanup-complete-fixed.sh
```

## ⚙️ Configuration

### Environment Variables
```bash
export AWS_REGION=us-east-1              # AWS region
export CLUSTER_NAME=my-eks-cluster       # EKS cluster name
export NAMESPACE=ecommerce               # Kubernetes namespace
```

### Customize Deployment
Edit these files to customize your deployment:
- `Terraform/main.tf` - Infrastructure configuration
- `k8s/*.yaml` - Application manifests
- `k8s/deploy-eks-optimized.sh` - Deployment logic

## 📚 Additional Resources

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/)

## 💡 Best Practices

1. **Cost Management**
   - Use appropriate instance types
   - Set up auto-scaling
   - Monitor resource usage

2. **Security**
   - Use IAM roles for service accounts
   - Keep security groups restrictive
   - Enable logging and monitoring

3. **High Availability**
   - Deploy across multiple AZs
   - Use multiple replicas
   - Set up health checks

4. **Performance**
   - Configure resource limits
   - Use persistent volumes for data
   - Monitor application metrics

## 🎯 Next Steps

After successful deployment:

1. **Configure Domain** - Set up custom domain and SSL
2. **Monitoring** - Set up CloudWatch or Prometheus monitoring
3. **CI/CD** - Integrate with Jenkins or GitHub Actions
4. **Backup** - Configure database backups
5. **Security** - Implement network policies and RBAC

---

**Happy deploying! 🚀**

For issues or questions, check the troubleshooting section or review the generated logs in the `outputs/` directory.
