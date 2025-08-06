# Kubernetes Manifests Documentation

This document provides a comprehensive overview of the Kubernetes manifests and deployment configurations used in the ITI E-Commerce Platform project.

## Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Core Manifests (k8s/)](#core-manifests-k8s)
- [EKS Optimized Manifests (k88s/)](#eks-optimized-manifests-k88s)
- [Deployment Scripts](#deployment-scripts)
- [Storage Configuration](#storage-configuration)
- [Monitoring and Observability](#monitoring-and-observability)
- [Best Practices](#best-practices)

## Overview

The project contains two main Kubernetes configuration directories:
- **k8s/**: Core Kubernetes manifests for standard deployment
- **k88s/**: EKS-optimized manifests with AWS-specific configurations

Both directories provide complete deployment configurations for the e-commerce platform, including the Node.js backend, React frontend, MongoDB database, and supporting infrastructure.

## Directory Structure

### Core Manifests (k8s/)

```
k8s/
├── 00-namespace.yaml              # Namespace definition
├── 01-configmap-secret.yaml      # Configuration and secrets
├── 02-mongodb.yaml               # MongoDB deployment
├── 03-backend.yaml               # Node.js backend service
├── 04-frontend.yaml              # React frontend service
├── 05-ingress.yaml               # Ingress controller
├── 06-monitoring.yaml            # Monitoring stack
├── 07-seed-job.yaml              # Database seeding job
├── 08-loadbalancer-services.yaml # LoadBalancer services
├── 08-simple-loadbalancers.yaml  # Simplified LB configs
├── 09-alb-ingress.yaml           # ALB ingress for AWS
├── deploy-eks-ready.sh           # EKS deployment script
├── ebs-storage-classes.yaml      # EBS storage classes
└── mongodb-hostpath-storage.yaml # Local storage config
```

## Core Manifests (k8s/)

### 00-namespace.yaml
Creates the `iti-ecommerce` namespace for isolating application resources.

**Key Features:**
- Resource isolation
- Network policy boundaries
- RBAC scope definition

### 01-configmap-secret.yaml
Defines configuration maps and secrets for application settings.

**Key Components:**
- Database connection strings
- API endpoints
- Environment-specific configurations
- Sensitive data management

### 02-mongodb.yaml
MongoDB database deployment with persistent storage.

**Key Features:**
- StatefulSet deployment
- Persistent volume claims
- Service configuration
- Resource limits and requests

### 03-backend.yaml
Node.js backend API deployment and service.

**Key Features:**
- Deployment with replica sets
- Service exposure (ClusterIP)
- Environment variable injection
- Health checks and probes

### 04-frontend.yaml
React frontend application deployment.

**Key Features:**
- Nginx-based serving
- Static asset optimization
- Service configuration
- Horizontal pod autoscaling

### 05-ingress.yaml
Ingress controller configuration for external traffic routing.

**Key Features:**
- Path-based routing
- SSL termination
- Load balancing
- Health check endpoints

### 06-monitoring.yaml
Monitoring stack deployment (Prometheus, Grafana).

**Key Features:**
- Metrics collection
- Dashboard visualization
- Alerting rules
- Service discovery

### 07-seed-job.yaml
Kubernetes Job for database initialization and product seeding.

**Key Features:**
- One-time execution
- Database population
- Initialization scripts
- Completion tracking

## EKS Optimized Manifests (k88s/)

### Key Differences from Standard k8s/

1. **AWS Integration**: Optimized for AWS EKS features
2. **Load Balancer**: AWS ALB integration
3. **Storage**: EBS persistent volumes
4. **Networking**: VPC and security group integration
5. **IAM**: Service account and role bindings

### Deployment Scripts

#### Core Deployment Scripts
- `deploy.sh`: Main deployment script
- `deploy-eks-optimized.sh`: EKS-specific deployment
- `deploy-fixed.sh`: Fixed deployment with error handling

#### Build and Push Scripts
- `build-push-image.sh`: Docker image building and pushing
- `build-push-frontend.sh`: Frontend-specific build script

#### Setup Scripts
- `create-cluster.sh`: EKS cluster creation
- `setup-ecr.sh`: ECR repository setup
- `install-argocd.sh`: ArgoCD installation
- `install-cert-manager.sh`: Certificate manager setup

#### Verification Scripts
- `check-application.sh`: Application health checks
- `check-products.sh`: Product API verification
- `verify-argocd.sh`: ArgoCD status verification
- `test-access.sh`: Access testing

#### Cleanup Scripts
- `cleanup.sh`: Resource cleanup
- `cleanup-deployment.sh`: Deployment-specific cleanup

## Storage Configuration

### EBS Storage Classes
```yaml
# ebs-storage-classes.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp2-encrypted
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  encrypted: "true"
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
```

### HostPath Storage (Development)
```yaml
# mongodb-hostpath-storage.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongodb-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /data/mongodb
```

## Monitoring and Observability

### Prometheus Configuration
- Metrics scraping configuration
- Service discovery rules
- Alert manager integration
- Custom metrics collection

### Grafana Dashboards
- Application performance metrics
- Infrastructure monitoring
- Business metrics visualization
- Alert notifications

## Best Practices

### Security
1. **Secrets Management**: Use Kubernetes secrets for sensitive data
2. **RBAC**: Implement role-based access control
3. **Network Policies**: Restrict pod-to-pod communication
4. **Security Contexts**: Run containers with minimal privileges

### Performance
1. **Resource Requests/Limits**: Define appropriate resource boundaries
2. **HPA**: Implement horizontal pod autoscaling
3. **Node Affinity**: Optimize pod placement
4. **Persistent Volumes**: Use appropriate storage classes

### Reliability
1. **Health Checks**: Implement liveness and readiness probes
2. **Rolling Updates**: Configure deployment strategies
3. **Backup Strategy**: Regular database backups
4. **Disaster Recovery**: Multi-AZ deployment

### Maintenance
1. **Version Management**: Track and update image versions
2. **Configuration Management**: Use ConfigMaps for environment settings
3. **Logging**: Centralized log collection
4. **Monitoring**: Comprehensive observability stack

## Deployment Workflow

1. **Preparation**:
   ```bash
   # Create namespace
   kubectl apply -f k8s/00-namespace.yaml
   
   # Apply configurations
   kubectl apply -f k8s/01-configmap-secret.yaml
   ```

2. **Database Deployment**:
   ```bash
   # Deploy MongoDB
   kubectl apply -f k8s/02-mongodb.yaml
   
   # Wait for database to be ready
   kubectl wait --for=condition=ready pod -l app=mongodb
   ```

3. **Application Deployment**:
   ```bash
   # Deploy backend
   kubectl apply -f k8s/03-backend.yaml
   
   # Deploy frontend
   kubectl apply -f k8s/04-frontend.yaml
   ```

4. **Networking**:
   ```bash
   # Configure ingress
   kubectl apply -f k8s/05-ingress.yaml
   ```

5. **Monitoring**:
   ```bash
   # Deploy monitoring stack
   kubectl apply -f k8s/06-monitoring.yaml
   ```

6. **Data Seeding**:
   ```bash
   # Run seed job
   kubectl apply -f k8s/07-seed-job.yaml
   ```

## Troubleshooting

### Common Issues
1. **ImagePullBackOff**: Check image availability and credentials
2. **CrashLoopBackOff**: Review application logs and configuration
3. **Pending Pods**: Verify resource availability and scheduling constraints
4. **Service Connectivity**: Check service discovery and network policies

### Debugging Commands
```bash
# Check pod status
kubectl get pods -n iti-ecommerce

# View pod logs
kubectl logs -f <pod-name> -n iti-ecommerce

# Describe resources
kubectl describe pod <pod-name> -n iti-ecommerce

# Access pod shell
kubectl exec -it <pod-name> -n iti-ecommerce -- /bin/bash
```

## Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [AWS EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/)
- [Kubectl Reference](https://kubernetes.io/docs/reference/kubectl/)
- [Project Deployment Guide](KUBERNETES-DEPLOYMENT-GUIDE.md)
