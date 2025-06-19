# EKS-Ready Kubernetes Deployment Files

Your Kubernetes files are now optimized and ready for EKS deployment! 🚀

## 📁 **New Optimized Files Created:**

### **Core Application Files:**
- `00-namespace.yaml` - Namespace with proper labels
- `01-configmap-secret.yaml` - Configuration and secrets with AWS region updated
- `02-mongodb.yaml` - MongoDB with EKS-compatible storage (gp2) and updated probes
- `03-backend.yaml` - Backend API with improved health checks and resource limits
- `04-frontend.yaml` - Frontend with proper resource management
- `05-ingress.yaml` - Dual ingress setup (domain + IP based) with proper annotations
- `06-monitoring.yaml` - Prometheus monitoring setup
- `07-seed-job.yaml` - Product seeding job with init containers

### **Deployment Script:**
- `deploy-eks-optimized.sh` - Complete EKS deployment script

## ✅ **EKS Optimizations Applied:**

### **1. Storage Configuration**
- ✅ Updated storage class to `gp2` (AWS EBS)
- ✅ Increased MongoDB storage to 20GB for production
- ✅ Proper PVC configuration for EKS

### **2. Container Images**
- ✅ Updated to use `latest` tags for auto-updates
- ✅ Proper image pull policies
- ✅ ECR public repository references

### **3. Resource Management**
- ✅ Proper CPU/Memory limits and requests
- ✅ Production-ready resource allocation
- ✅ Optimized for EKS node types

### **4. Health Checks**
- ✅ Updated MongoDB probes to use `mongosh` (MongoDB 5.0+)
- ✅ Proper liveness and readiness probes
- ✅ Appropriate timeout and retry settings

### **5. Networking**
- ✅ Dual ingress setup (domain + IP based)
- ✅ Proper CORS configuration
- ✅ Rate limiting and security annotations
- ✅ Modern ingress API (networking.k8s.io/v1)

### **6. Configuration**
- ✅ AWS region updated to `us-east-1`
- ✅ Proper secret and configmap structure
- ✅ Environment-specific settings

## 🚀 **Quick Deployment:**

### **Option 1: Use the Optimized Script**
```bash
cd k8s/
./deploy-eks-optimized.sh
```

### **Option 2: Manual Deployment**
```bash
cd k8s/

# Deploy in order
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-configmap-secret.yaml
kubectl apply -f 02-mongodb.yaml
kubectl apply -f 03-backend.yaml
kubectl apply -f 04-frontend.yaml
kubectl apply -f 05-ingress.yaml
kubectl apply -f 06-monitoring.yaml
kubectl apply -f 07-seed-job.yaml
```

## 📊 **What the Script Does:**

1. **Verifies Prerequisites** - kubectl, cluster connection
2. **Installs Infrastructure** - nginx-ingress, EBS CSI driver (if needed)
3. **Deploys Components** - In correct order with dependencies
4. **Waits for Readiness** - Ensures each component starts properly
5. **Seeds Data** - Runs initial product data seeding
6. **Provides Access Info** - Shows URLs and troubleshooting commands

## 🌐 **Access Your Application:**

After deployment, you'll get access information like:
```
Application URL: http://<LOAD_BALANCER_IP>
API URL: http://<LOAD_BALANCER_IP>/api
Prometheus: http://<LOAD_BALANCER_IP>:9090
```

## 🔍 **Monitoring & Troubleshooting:**

### **Check Status:**
```bash
kubectl get pods -n ecommerce
kubectl get services -n ecommerce
kubectl get ingress -n ecommerce
```

### **View Logs:**
```bash
kubectl logs -f deployment/frontend-deployment -n ecommerce
kubectl logs -f deployment/backend-deployment -n ecommerce
kubectl logs -f deployment/mongodb-deployment -n ecommerce
```

### **Common Issues:**
- **ImagePullBackOff**: Check if ECR images are accessible
- **Pending PVC**: Ensure EBS CSI driver is installed
- **Ingress not working**: Check nginx-ingress controller status

## 🔄 **Updating Application:**

To update your application:
```bash
# Update image tags in deployment files
kubectl set image deployment/backend-deployment backend=public.ecr.aws/w2s7s2g7/iti-project-backend:new-tag -n ecommerce
kubectl set image deployment/frontend-deployment frontend=public.ecr.aws/w2s7s2g7/iti-project-frontend:new-tag -n ecommerce
```

## 🧹 **Cleanup:**

To remove everything:
```bash
kubectl delete namespace ecommerce
```

Your Kubernetes files are now production-ready for EKS! 🎯
