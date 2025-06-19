# Complete Kubernetes Deployment Guide for E-commerce Application

This repository contains comprehensive scripts to deploy a full e-commerce application on Amazon EKS with all necessary components.

## 🚀 Quick Start

### Prerequisites
- AWS CLI configured with appropriate permissions
- kubectl configured to connect to your EKS cluster
- Bash shell environment

### One-Command Deployment
```bash
./deploy-all-resources.sh
```

This single script will:
1. ✅ Verify all prerequisites
2. 🔧 Install cert-manager
3. 🔧 Install nginx-ingress controller
4. 🔧 Install AWS EBS CSI driver
5. 📦 Deploy MongoDB (temporary storage)
6. 📦 Deploy backend and frontend services
7. 📦 Deploy monitoring (Prometheus)
8. 🌐 Configure ingress and networking
9. 📋 Provide access information

## 📋 Available Scripts

### 1. `deploy-all-resources.sh` - Complete Deployment
**Primary deployment script** that installs everything from scratch.

**What it does:**
- Installs all Kubernetes infrastructure components
- Deploys the complete e-commerce application
- Sets up networking and ingress
- Provides comprehensive status reporting

**Usage:**
```bash
./deploy-all-resources.sh
```

### 2. `setup-persistent-storage.sh` - Persistent Storage Setup
Sets up AWS EBS persistent storage with proper IAM permissions.

**What it does:**
- Creates IAM policies and roles for EBS CSI driver
- Configures service account annotations
- Deploys MongoDB with persistent storage
- Provides migration options from temporary storage

**Usage:**
```bash
./setup-persistent-storage.sh
```

### 3. `cleanup-environment.sh` - Complete Cleanup
Removes all deployed resources and resets the environment.

**What it does:**
- Deletes application namespace and all resources
- Optionally removes infrastructure components
- Cleans up AWS IAM resources
- Provides confirmation prompts for safety

**Usage:**
```bash
./cleanup-environment.sh
```

## 🏗️ Architecture Overview

### Components Deployed
- **Frontend**: React-based e-commerce UI
- **Backend**: Node.js API server
- **Database**: MongoDB with optional persistent storage
- **Monitoring**: Prometheus for metrics
- **Ingress**: nginx-ingress for external access
- **Security**: cert-manager for TLS certificates

### Infrastructure Components
- **cert-manager**: Automatic TLS certificate management
- **nginx-ingress**: Load balancing and ingress control
- **EBS CSI Driver**: AWS persistent storage integration

## 📁 Directory Structure

```
ITI-Project/
├── deploy-all-resources.sh      # 🎯 Main deployment script
├── setup-persistent-storage.sh  # 💾 Persistent storage setup
├── cleanup-environment.sh       # 🧹 Complete cleanup
├── k8s/                         # Kubernetes manifests
│   ├── backend.yaml
│   ├── frontend.yaml
│   ├── mongodb.yaml
│   ├── ingress.yaml
│   ├── configmap-secret.yaml
│   └── ...
└── outputs/                     # Generated output files
    ├── access-info.txt
    ├── terraform-outputs.json
    └── ...
```

## 🔧 Deployment Options

### Option 1: Complete Fresh Deployment
```bash
# Deploy everything from scratch
./deploy-all-resources.sh
```

### Option 2: Deploy with Persistent Storage
```bash
# First deploy the application
./deploy-all-resources.sh

# Then set up persistent storage
./setup-persistent-storage.sh
```

### Option 3: Clean and Redeploy
```bash
# Clean everything
./cleanup-environment.sh

# Deploy fresh
./deploy-all-resources.sh
```

## 🌐 Accessing Your Application

After deployment, the script will provide access information:

```
🌐 Access Information:
=====================
Ingress IP: <YOUR_LOAD_BALANCER_IP>
Application URL: http://<YOUR_LOAD_BALANCER_IP>
API URL: http://<YOUR_LOAD_BALANCER_IP>/api
```

### Service Endpoints
- **Frontend**: `http://<INGRESS_IP>/`
- **API**: `http://<INGRESS_IP>/api`
- **Uploads**: `http://<INGRESS_IP>/uploads`

## 📊 Monitoring and Troubleshooting

### Check Deployment Status
```bash
# Check all pods
kubectl get pods -n ecommerce

# Check services
kubectl get services -n ecommerce

# Check ingress
kubectl get ingress -n ecommerce
```

### View Logs
```bash
# Frontend logs
kubectl logs -f deployment/frontend-deployment -n ecommerce

# Backend logs
kubectl logs -f deployment/backend-deployment -n ecommerce

# MongoDB logs
kubectl logs -f deployment/mongodb-deployment-temp -n ecommerce
```

### Common Issues and Solutions

#### 1. ImagePullBackOff Errors
```bash
# Check if images are accessible
kubectl describe pod <pod-name> -n ecommerce

# Update image names in deployment files if needed
```

#### 2. Ingress Not Accessible
```bash
# Check ingress controller
kubectl get pods -n ingress-nginx

# Check ingress configuration
kubectl describe ingress ecommerce-ingress -n ecommerce
```

#### 3. Storage Issues
```bash
# Check PVC status
kubectl get pvc -n ecommerce

# Check storage class
kubectl get storageclass
```

## 🔒 Security Considerations

### IAM Permissions Required
The scripts require AWS IAM permissions for:
- EKS cluster access
- EC2 volume management (for EBS CSI driver)
- IAM role/policy creation (for persistent storage)

### Network Security
- All services are deployed in the `ecommerce` namespace
- Ingress controller provides external access
- Internal services communicate via ClusterIP

## 📝 Customization

### Environment Variables
Modify `k8s/configmap-secret.yaml` to update:
- Database connection strings
- API endpoints
- AWS configuration

### Resource Limits
Update resource limits in deployment files:
```yaml
resources:
  limits:
    memory: "1Gi"
    cpu: "500m"
  requests:
    memory: "512Mi"
    cpu: "250m"
```

### Storage Configuration
For persistent storage, modify storage class and size:
```yaml
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: gp2
```

## 🆘 Support and Troubleshooting

### Get Help
```bash
# Check events for errors
kubectl get events -n ecommerce --sort-by='.lastTimestamp'

# Describe problematic resources
kubectl describe pod <pod-name> -n ecommerce
kubectl describe ingress ecommerce-ingress -n ecommerce
```

### Reset Environment
If something goes wrong, you can always reset:
```bash
./cleanup-environment.sh
./deploy-all-resources.sh
```

## 🎯 Next Steps

After successful deployment:
1. ✅ Verify all services are running
2. 🌐 Access the application via the provided URL
3. 📊 Monitor using Prometheus (if enabled)
4. 💾 Consider setting up persistent storage
5. 🔒 Configure TLS certificates for production use

## 📚 Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [nginx-ingress Documentation](https://kubernetes.github.io/ingress-nginx/)
- [cert-manager Documentation](https://cert-manager.io/docs/)

---

**Happy Deploying! 🚀**
