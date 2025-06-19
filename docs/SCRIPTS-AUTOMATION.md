# Scripts Documentation

This document provides a comprehensive overview of all automation scripts used in the ITI E-Commerce Platform project for deployment, management, and maintenance tasks.

## Table of Contents

- [Overview](#overview)
- [Script Categories](#script-categories)
- [Deployment Scripts](#deployment-scripts)
- [Infrastructure Management](#infrastructure-management)
- [Verification and Testing](#verification-and-testing)
- [Cleanup and Maintenance](#cleanup-and-maintenance)
- [Monitoring Scripts](#monitoring-scripts)
- [Utility Scripts](#utility-scripts)
- [Usage Guidelines](#usage-guidelines)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)

## Overview

The ITI E-Commerce Platform includes an extensive collection of automation scripts designed to streamline deployment, management, and maintenance operations. These scripts are organized across multiple directories and provide functionality for:

- Infrastructure deployment and management
- Application deployment and configuration
- Verification and testing procedures
- Cleanup and maintenance operations
- Monitoring and observability setup

### Script Locations
```
scripts/                    # Main infrastructure scripts
k88s/                      # Kubernetes and EKS-specific scripts
k8s/                       # Standard Kubernetes scripts
Ansible/                   # Ansible playbook scripts
Terraform/                 # Infrastructure provisioning scripts
```

## Script Categories

### 1. Infrastructure Scripts (`/scripts/`)
Core infrastructure management and deployment automation.

### 2. Kubernetes Scripts (`/k88s/` and `/k8s/`)
Container orchestration, deployment, and management scripts.

### 3. CI/CD Integration Scripts
Jenkins pipeline integration and automation.

### 4. Verification Scripts
Health checks, testing, and validation automation.

### 5. Cleanup Scripts
Resource cleanup and environment maintenance.

## Deployment Scripts

### Infrastructure Deployment

#### `deploy-complete-infrastructure.sh`
**Purpose**: Complete infrastructure deployment including Terraform and Kubernetes resources.

**Location**: `/scripts/deploy-complete-infrastructure.sh`

**Key Features**:
- Terraform infrastructure provisioning
- Kubernetes cluster setup
- Application deployment
- Configuration management

**Usage**:
```bash
./scripts/deploy-complete-infrastructure.sh
```

**Script Flow**:
1. Initialize Terraform workspace
2. Plan and apply infrastructure changes
3. Configure kubectl context
4. Deploy Kubernetes manifests
5. Verify deployment status

#### `deploy-all-resources.sh`
**Purpose**: Deploy all application resources to existing infrastructure.

**Location**: `/scripts/deploy-all-resources.sh`

**Features**:
- Sequential resource deployment
- Dependency management
- Error handling and rollback
- Progress monitoring

**Usage**:
```bash
./scripts/deploy-all-resources.sh [environment]
```

#### `deploy-infrastructure.sh`
**Purpose**: Core infrastructure deployment script.

**Location**: `/scripts/deploy-infrastructure.sh`

**Components**:
- VPC and networking setup
- EKS cluster provisioning
- IAM roles and policies
- Storage configuration

### Kubernetes Deployment

#### `deploy-eks-optimized.sh`
**Purpose**: EKS-optimized deployment with AWS-specific configurations.

**Location**: `/k88s/deploy-eks-optimized.sh`

**Features**:
- EKS-specific resource definitions
- AWS Load Balancer Controller integration
- EBS CSI driver configuration
- IAM Service Account setup

**Usage**:
```bash
cd k88s
./deploy-eks-optimized.sh
```

**Script Components**:
```bash
#!/bin/bash
set -e

echo "Starting EKS-optimized deployment..."

# Create namespace
kubectl apply -f namespace.yaml

# Apply configuration and secrets
kubectl apply -f configmap-secret.yaml

# Deploy MongoDB with persistent storage
kubectl apply -f mongodb-persistent.yaml

# Deploy backend service
kubectl apply -f backend.yaml

# Deploy frontend service
kubectl apply -f frontend.yaml

# Configure ingress
kubectl apply -f ingress.yaml

# Setup monitoring
kubectl apply -f monitoring.yaml

# Seed database
kubectl apply -f seed-products-job.yaml

echo "EKS deployment completed successfully!"
```

#### `deploy.sh`
**Purpose**: Standard Kubernetes deployment script.

**Location**: `/k88s/deploy.sh`

**Features**:
- Standard Kubernetes resource deployment
- Health check validation
- Service readiness verification

#### `deploy-eks-ready.sh`
**Purpose**: EKS-ready deployment script with enhanced features.

**Location**: `/k8s/deploy-eks-ready.sh`

**Advanced Features**:
- Automatic cluster validation
- Resource quota management
- Network policy enforcement
- Security context validation

## Infrastructure Management

### Cluster Management

#### `create-cluster.sh`
**Purpose**: Automated EKS cluster creation with optimal configuration.

**Location**: `/k88s/create-cluster.sh`

**Features**:
- EKS cluster provisioning
- Node group configuration
- Add-on installation
- Security group setup

**Usage**:
```bash
cd k88s
./create-cluster.sh [cluster-name] [region]
```

**Script Details**:
```bash
#!/bin/bash

CLUSTER_NAME=${1:-"iti-eks-cluster"}
REGION=${2:-"us-east-1"}

echo "Creating EKS cluster: $CLUSTER_NAME in region: $REGION"

# Create EKS cluster
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --version 1.24 \
  --nodegroup-name standard-workers \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 1 \
  --nodes-max 4 \
  --managed

# Install AWS Load Balancer Controller
eksctl utils associate-iam-oidc-provider --region $REGION --cluster $CLUSTER_NAME --approve

# Install EBS CSI driver
eksctl create addon --name aws-ebs-csi-driver --cluster $CLUSTER_NAME --region $REGION

echo "Cluster creation completed!"
```

#### `setup-ecr.sh`
**Purpose**: Amazon ECR repository setup and configuration.

**Location**: `/k88s/setup-ecr.sh`

**Features**:
- ECR repository creation
- IAM permissions setup
- Docker registry authentication
- Repository policy configuration

**Usage**:
```bash
cd k88s
./setup-ecr.sh
```

### Storage Management

#### `setup-persistent-storage.sh`
**Purpose**: Configure persistent storage for stateful applications.

**Location**: `/scripts/setup-persistent-storage.sh`

**Features**:
- EBS volume provisioning
- Storage class configuration
- Persistent volume creation
- Backup configuration

**Components**:
- Dynamic volume provisioning
- Encryption at rest
- Snapshot policies
- Performance optimization

### Certificate Management

#### `install-cert-manager.sh`
**Purpose**: Install and configure cert-manager for SSL/TLS automation.

**Location**: `/k88s/install-cert-manager.sh`

**Features**:
- Cert-manager installation
- ClusterIssuer configuration
- Let's Encrypt integration
- Certificate automation

**Usage**:
```bash
cd k88s
./install-cert-manager.sh
```

## Verification and Testing

### Application Testing

#### `check-application.sh`
**Purpose**: Comprehensive application health and functionality verification.

**Location**: `/k88s/check-application.sh`

**Checks**:
- Pod health status
- Service connectivity
- Ingress functionality
- Database connectivity
- API endpoint responses

**Usage**:
```bash
cd k88s
./check-application.sh
```

**Script Logic**:
```bash
#!/bin/bash

echo "Checking application health..."

# Check pod status
echo "Checking pod status..."
kubectl get pods -n ecommerce

# Check services
echo "Checking services..."
kubectl get services -n ecommerce

# Test backend API
echo "Testing backend API..."
BACKEND_URL=$(kubectl get service backend -n ecommerce -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
curl -f http://$BACKEND_URL:5000/health || echo "Backend health check failed"

# Test frontend
echo "Testing frontend..."
FRONTEND_URL=$(kubectl get service frontend -n ecommerce -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
curl -f http://$FRONTEND_URL || echo "Frontend check failed"

# Check database connectivity
echo "Checking database connectivity..."
kubectl exec -n ecommerce deployment/backend -- curl -f http://localhost:5000/api/products

echo "Application health check completed!"
```

#### `verify-products.sh`
**Purpose**: Verify product API functionality and data integrity.

**Location**: `/k88s/verify-products.sh`

**Features**:
- Product API endpoint testing
- Data validation
- Performance testing
- Error scenario testing

#### `check-api-products.sh`
**Purpose**: Detailed API endpoint verification for product operations.

**Location**: `/k88s/check-api-products.sh`

**Test Cases**:
- GET /api/products
- GET /api/products/:id
- POST /api/products (admin)
- PUT /api/products/:id (admin)
- DELETE /api/products/:id (admin)

### Infrastructure Testing

#### `test-access.sh`
**Purpose**: Test external access to deployed applications.

**Location**: `/k88s/test-access.sh`

**Tests**:
- Load balancer connectivity
- Ingress routing
- SSL certificate validation
- DNS resolution

#### `test-ingress.sh`
**Purpose**: Ingress controller and routing verification.

**Location**: `/k88s/test-ingress.sh`

**Features**:
- Path-based routing tests
- Host-based routing tests
- SSL/TLS verification
- Rate limiting tests

### ArgoCD Verification

#### `verify-argocd.sh`
**Purpose**: ArgoCD installation and configuration verification.

**Location**: `/k88s/verify-argocd.sh`

**Checks**:
- ArgoCD component health
- Application sync status
- Repository connectivity
- UI accessibility

**Usage**:
```bash
cd k88s
./verify-argocd.sh
```

#### `check-argocd.sh`
**Purpose**: Detailed ArgoCD status and health monitoring.

**Location**: `/k88s/check-argocd.sh`

**Features**:
- Component status verification
- Application health monitoring
- Sync operation status
- Performance metrics

## Cleanup and Maintenance

### Environment Cleanup

#### `cleanup-complete-fixed.sh`
**Purpose**: Comprehensive environment cleanup with enhanced error handling.

**Location**: `/scripts/cleanup-complete-fixed.sh`

**Features**:
- Kubernetes resource cleanup
- Terraform state cleanup
- ECR image cleanup
- IAM resource cleanup

**Usage**:
```bash
./scripts/cleanup-complete-fixed.sh [--force]
```

**Cleanup Process**:
1. Application resource deletion
2. Infrastructure resource cleanup
3. Storage volume cleanup
4. Network resource cleanup
5. Security resource cleanup

#### `cleanup-deployment.sh`
**Purpose**: Application-specific deployment cleanup.

**Location**: `/k88s/cleanup-deployment.sh`

**Scope**:
- Pod and deployment cleanup
- Service cleanup
- ConfigMap and Secret cleanup
- PersistentVolume cleanup

#### `cleanup-environment.sh`
**Purpose**: Complete environment reset and cleanup.

**Location**: `/scripts/cleanup-environment.sh`

**Features**:
- Multi-environment support
- Selective cleanup options
- Backup before cleanup
- Confirmation prompts

### Terraform Cleanup

#### `cleanup-terraform-state.sh`
**Purpose**: Terraform state file cleanup and management.

**Location**: `/scripts/cleanup-terraform-state.sh`

**Features**:
- State file backup
- Resource state cleanup
- Lock file management
- Workspace cleanup

#### `cleanup-terraform-errors.sh`
**Purpose**: Resolve Terraform state errors and inconsistencies.

**Location**: `/scripts/cleanup-terraform-errors.sh`

**Error Resolution**:
- State file corruption
- Resource drift issues
- Provider configuration problems
- Lock file conflicts

### AWS Resource Cleanup

#### `cleanup-ecr.sh`
**Purpose**: ECR repository and image cleanup.

**Location**: `/scripts/cleanup-ecr.sh`

**Features**:
- Old image cleanup
- Repository policy cleanup
- Lifecycle policy application
- Cost optimization

## Monitoring Scripts

### ArgoCD Monitoring

#### `install-argocd.sh`
**Purpose**: Install ArgoCD with monitoring and observability features.

**Location**: `/k88s/install-argocd.sh`

**Features**:
- ArgoCD core installation
- Prometheus integration
- Grafana dashboard setup
- Notification configuration

**Usage**:
```bash
cd k88s
./install-argocd.sh
```

#### `argocd-access-info.sh`
**Purpose**: Display ArgoCD access information and credentials.

**Location**: `/k88s/argocd-access-info.sh`

**Information Provided**:
- UI access URL
- Initial admin password
- CLI login instructions
- API endpoint details

### Application Monitoring

#### `populate-products.sh`
**Purpose**: Populate database with sample products for testing and monitoring.

**Location**: `/k88s/populate-products.sh`

**Features**:
- Sample data generation
- Performance testing data
- Monitoring baseline establishment
- Load testing preparation

## Utility Scripts

### Build and Push Scripts

#### `build-push-image.sh`
**Purpose**: Automated Docker image building and pushing to registry.

**Location**: `/k88s/build-push-image.sh`

**Features**:
- Multi-architecture builds
- Image tagging strategies
- Registry authentication
- Build optimization

**Usage**:
```bash
cd k88s
./build-push-image.sh [component] [version]
```

#### `build-push-frontend.sh`
**Purpose**: Frontend-specific build and push automation.

**Location**: `/k88s/build-push-frontend.sh`

**Features**:
- React build optimization
- Static asset management
- CDN integration
- Cache management

### Configuration Management

#### `update-aws-credentials.sh`
**Purpose**: AWS credentials update and management.

**Location**: `/k88s/update-aws-credentials.sh`

**Features**:
- Credential rotation
- Multiple profile support
- Security validation
- Integration testing

#### `update-manifests.sh`
**Purpose**: Kubernetes manifest updates and validation.

**Location**: `/k88s/update-manifests.sh`

**Features**:
- Template processing
- Variable substitution
- Validation checks
- Rollback preparation

### Development Utilities

#### `disable-ci-errors.sh`
**Purpose**: Disable CI errors for development and testing.

**Location**: `/k88s/disable-ci-errors.sh`

**Features**:
- ESLint configuration
- Build warning suppression
- Development mode setup
- Testing configuration

#### `fix-eslint-issues.sh`
**Purpose**: Automated ESLint error fixing and code formatting.

**Location**: `/k88s/fix-eslint-issues.sh`

**Features**:
- Automatic fix application
- Code formatting
- Style consistency
- Pre-commit validation

## Usage Guidelines

### Script Execution Prerequisites

#### Environment Setup
```bash
# Ensure required tools are installed
kubectl version --client
terraform version
aws --version
docker version

# Set up environment variables
export AWS_REGION=us-east-1
export CLUSTER_NAME=iti-eks-cluster
export NAMESPACE=ecommerce
```

#### Permissions and Access
- AWS CLI configured with appropriate permissions
- kubectl configured for target cluster
- Docker registry access configured
- Git repository access for ArgoCD

### Script Execution Order

#### Initial Deployment
1. `deploy-complete-infrastructure.sh` - Complete infrastructure setup
2. `install-argocd.sh` - Install GitOps operator
3. `deploy-eks-optimized.sh` - Deploy applications
4. `populate-products.sh` - Initialize data
5. `verify-argocd.sh` - Verify deployment

#### Daily Operations
1. `check-application.sh` - Health monitoring
2. `verify-products.sh` - API validation
3. `update-manifests.sh` - Configuration updates
4. `build-push-image.sh` - New deployments

#### Maintenance
1. `cleanup-deployment.sh` - Clean deployments
2. `cleanup-terraform-state.sh` - State maintenance
3. `cleanup-ecr.sh` - Registry cleanup
4. `cleanup-complete-fixed.sh` - Full cleanup

## Error Handling

### Common Error Patterns

#### Infrastructure Errors
```bash
# Terraform state lock errors
terraform force-unlock <lock-id>

# AWS resource limit errors
aws service-quotas get-service-quota --service-code eks --quota-code L-1194D53C

# EKS cluster access errors
aws eks update-kubeconfig --region us-east-1 --name iti-eks-cluster
```

#### Application Errors
```bash
# Pod startup failures
kubectl describe pod <pod-name> -n ecommerce
kubectl logs <pod-name> -n ecommerce

# Service connectivity issues
kubectl port-forward service/backend 5000:5000 -n ecommerce

# Ingress configuration problems
kubectl describe ingress -n ecommerce
```

### Error Recovery Procedures

#### Rollback Strategies
1. **Application Rollback**: Use ArgoCD UI or CLI
2. **Infrastructure Rollback**: Terraform state reversion
3. **Configuration Rollback**: Git revert and sync
4. **Database Rollback**: Backup restoration

#### Disaster Recovery
1. **Cluster Recreation**: Complete cluster rebuild
2. **Data Recovery**: Backup restoration procedures
3. **Configuration Recovery**: Git history restoration
4. **Service Recovery**: Step-by-step service restoration

## Best Practices

### Script Development
1. **Error Handling**: Use `set -e` for error propagation
2. **Logging**: Comprehensive logging with timestamps
3. **Validation**: Input validation and prerequisite checks
4. **Documentation**: Inline comments and usage examples

### Security Practices
1. **Credential Management**: Use environment variables or secret managers
2. **Access Control**: Implement least privilege principles
3. **Audit Logging**: Track script execution and changes
4. **Validation**: Verify operations before execution

### Performance Optimization
1. **Parallel Execution**: Use background processes where appropriate
2. **Caching**: Implement caching for repeated operations
3. **Resource Management**: Monitor and limit resource usage
4. **Batch Operations**: Group related operations together

### Maintenance
1. **Regular Updates**: Keep scripts updated with latest practices
2. **Testing**: Regular testing in non-production environments
3. **Documentation**: Maintain current documentation
4. **Monitoring**: Monitor script execution and performance

## Script Templates

### Basic Script Template
```bash
#!/bin/bash
set -e

# Script: script-name.sh
# Purpose: Brief description of script purpose
# Usage: ./script-name.sh [arguments]

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/tmp/$(basename "$0" .sh).log"

# Functions
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error() {
    log "ERROR: $1" >&2
    exit 1
}

# Main script logic
main() {
    log "Starting $(basename "$0")"
    
    # Script implementation here
    
    log "$(basename "$0") completed successfully"
}

# Execute main function
main "$@"
```

### Kubernetes Script Template
```bash
#!/bin/bash
set -e

# Kubernetes deployment script template

NAMESPACE=${1:-"default"}
CONTEXT=${2:-"$(kubectl config current-context)"}

# Verify kubectl access
kubectl cluster-info --context="$CONTEXT" > /dev/null || error "Unable to access cluster"

# Verify namespace
kubectl get namespace "$NAMESPACE" --context="$CONTEXT" > /dev/null 2>&1 || {
    log "Creating namespace: $NAMESPACE"
    kubectl create namespace "$NAMESPACE" --context="$CONTEXT"
}

# Deploy resources
log "Deploying to namespace: $NAMESPACE"
kubectl apply -f . --namespace="$NAMESPACE" --context="$CONTEXT"

# Verify deployment
log "Verifying deployment..."
kubectl wait --for=condition=available deployment --all --timeout=300s --namespace="$NAMESPACE" --context="$CONTEXT"

log "Deployment completed successfully"
```

## Integration with CI/CD

The automation scripts integrate seamlessly with the Jenkins CI/CD pipeline:

### Pipeline Integration Points
1. **Build Stage**: Image building and pushing scripts
2. **Test Stage**: Verification and testing scripts
3. **Deploy Stage**: Deployment and configuration scripts
4. **Monitor Stage**: Health check and monitoring scripts

### GitOps Integration
- Scripts update Kubernetes manifests
- ArgoCD detects changes and syncs automatically
- Verification scripts validate deployments
- Monitoring scripts ensure application health

## Additional Resources

- [Bash Best Practices](https://google.github.io/styleguide/shellguide.html)
- [Kubernetes Scripting Guide](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [Terraform Automation](https://learn.hashicorp.com/terraform)
- [Docker Automation](https://docs.docker.com/engine/reference/commandline/)
