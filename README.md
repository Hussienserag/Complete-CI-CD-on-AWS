
# ITI E-Commerce Platform - Amazona

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Docker](https://img.shields.io/badge/docker-enabled-blue.svg)]()
[![Kubernetes](https://img.shields.io/badge/kubernetes-ready-326ce5.svg)]()
[![Terraform](https://img.shields.io/badge/terraform-IaC-623ce4.svg)]()
[![Ansible](https://img.shields.io/badge/ansible-automation-ee0000.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

**Information Technology Institute (ITI) - AWS Restart Track Final Project**

A comprehensive, enterprise-grade e-commerce platform showcasing modern DevOps practices and cloud-native architecture. Built with the MERN stack and deployed using Infrastructure as Code (Terraform), Configuration Management (Ansible), Container Orchestration (Kubernetes), CI/CD automation (Jenkins), and GitOps workflows (ArgoCD).

## DevOps Architecture Overview

This project demonstrates a complete DevOps lifecycle implementation:

- **Infrastructure as Code (IaC)** - Terraform modules for AWS infrastructure provisioning
- **Configuration Management** - Ansible playbooks for server configuration and software installation
- **Containerization** - Docker multi-stage builds for optimized application containers
- **Container Orchestration** - Kubernetes manifests for scalable production deployment
- **CI/CD Pipeline** - Jenkins declarative pipeline with automated testing and deployment
- **GitOps** - ArgoCD for declarative, Git-driven continuous deployment
- **Monitoring & Observability** - AWS CloudWatch integration for comprehensive monitoring
- **Security** - SSL/TLS automation, secrets management, and security scanning

## Features

### Core E-Commerce Features
- **User Authentication & Authorization** - JWT-based secure authentication system
- **Product Catalog Management** - Complete CRUD operations with image upload to AWS S3
- **Shopping Cart & Checkout** - Real-time cart management with secure payment processing
- **Order Management System** - Full order lifecycle from placement to fulfillment
- **User Profile Management** - Account settings, order history, and preferences
- **Admin Dashboard** - Administrative interface for product and order management
- **Responsive Design** - Mobile-first UI built with React and Bootstrap

### Technical & DevOps Features
- **Microservices Architecture** - Scalable, containerized service design
- **RESTful API** - Well-structured backend with Express.js and MongoDB
- **Cloud Storage Integration** - AWS S3 for file uploads and static assets
- **Database Management** - MongoDB with Mongoose ODM and persistent storage
- **SSL/TLS Encryption** - Automated certificate management with cert-manager
- **Load Balancing** - NGINX ingress controller with traffic distribution
- **Auto-scaling** - Horizontal Pod Autoscaling based on CPU/memory metrics
- **Backup & Recovery** - Automated AWS backup strategies for data protection

## Architecture Diagrams

### CI/CD Pipeline Architecture
![CI/CD Pipeline](./svg/cicd.drawio.svg)

### AWS Infrastructure Overview
![AWS Infrastructure](./svg/infra_aws.drawio.svg)

### Kubernetes Cluster Topology
![Kubernetes Architecture](./svg/k8s.drawio.svg)

### Continuous Integration Flow
![Continuous Integration](./svg/ci.drawio.svg)

### Continuous Deployment Workflow
![Continuous Deployment](./svg/cd.drawio.svg)

### Complete DevOps Workflow
![Complete CI/CD Workflow](./svg/Cicd_kh.drawio.svg)

## Project Structure - DevOps Architecture

```
ITI-Project/
├── Infrastructure as Code (Terraform/)
│   ├── main.tf                         # Main infrastructure orchestration
│   ├── variables.tf                    # Input variables definition
│   ├── terraform.tfvars               # Environment-specific values
│   ├── Provider_init.tf               # AWS provider configuration
│   ├── Inventory_Output.tf            # Ansible inventory generation
│   └── Modules/                       # Reusable infrastructure modules
│       ├── Network_Module/            # VPC, subnets, security groups
│       ├── Jenkins_EC2_Module/        # Jenkins server infrastructure
│       ├── EKS_Cluster_Module/        # Kubernetes cluster setup
│       ├── ECR_Module/                # Container registry configuration
│       ├── S3_Logs_Module/            # Centralized logging storage
│       └── Aws_Backup_Module/         # Backup and disaster recovery
│
├── Configuration Management (Ansible/)
│   ├── ansible.cfg                    # Ansible configuration
│   ├── my_inventory.ini              # Dynamic inventory from Terraform
│   ├── roles_playbook.yml            # Main playbook execution
│   └── roles/                        # Ansible roles for automation
│       ├── Jenkins_Server_Installation/    # Jenkins setup and configuration
│       ├── Docker_installation/           # Docker runtime installation
│       ├── Cloud_Watch_Agent_Installation/ # AWS monitoring agent
│       └── trivy_installation/           # Security vulnerability scanner
│
├── Container Orchestration (k8s/)
│   ├── Core Application Manifests
│   │   ├── namespace.yaml              # Application namespace isolation
│   │   ├── configmap-secret.yaml       # Environment configuration & secrets
│   │   ├── backend.yaml                # Node.js API deployment & service
│   │   ├── frontend.yaml               # React app deployment & service
│   │   └── mongodb.yaml                # MongoDB StatefulSet with persistence
│   ├── Network & Security
│       ├── ingress.yaml                # NGINX ingress with SSL termination
│       └── cert-manager.yaml           # Automated SSL certificate management
│
├── GitOps Configuration (argoCD/)
│   └── application.yaml               # ArgoCD application definition
│
├── CI/CD Pipeline
│   ├── Jenkinsfile                    # Declarative pipeline definition
│   └── sendDiscordNotification.groovy # Custom notification integration
│
├── Application Source Code
│   ├── backend/                       # Node.js/Express API server
│   │   ├── Dockerfile                 # Multi-stage production container
│   │   ├── models/                    # Database schemas (User, Product, Order)
│   │   ├── routes/                    # RESTful API endpoints
│   │   ├── server.js                  # Application entry point
│   │   └── package.json               # Dependencies and scripts
│   │
│   ├── frontend/                      # React single-page application
│   │   ├── Dockerfile                 # Optimized production build
│   │   ├── nginx.conf                 # Production web server configuration
│   │   ├── src/screens/               # React components and pages
│   │   ├── public/                    # Static assets
│   │   └── package.json               # Frontend dependencies
│   │
│   └── template/                      # Static landing pages
│       ├── index.html                 # Marketing page template
│       └── style.css                  # Custom styling
│
├── DevOps Documentation (docs/)
│   ├── DEPLOYMENT-SUMMARY.md          # Complete deployment architecture guide
│   ├── KUBERNETES-DEPLOYMENT-GUIDE.md # Step-by-step Kubernetes setup
│   ├── README-AWS-SETUP.md            # AWS services configuration guide
│   ├── README-KUBERNETES.md           # Kubernetes best practices
│   ├── FEATURE-SUMMARY.md             # Platform capabilities overview
│   └── KEY-CODE-SNIPPETS.js           # Critical implementation patterns
│
├── Architecture Visualization (svg/)
│   ├── cicd.drawio.svg                # CI/CD pipeline architecture
│   ├── infra_aws.drawio.svg           # AWS cloud infrastructure design
│   ├── k8s.drawio.svg                 # Kubernetes cluster topology
│   ├── ci.drawio.svg                  # Continuous integration workflow
│   ├── cd.drawio.svg                  # Continuous deployment process
│   └── Cicd_kh.drawio.svg             # End-to-end DevOps pipeline
│
└── Deployment Configurations
    ├── docker-compose.yaml            # Local development environment
    ├── Procfile                       # Heroku PaaS deployment configuration
    └── .env.example                   # Environment variables template
```

## Technology Stack

### Infrastructure & DevOps
- **Terraform** - Infrastructure as Code for AWS resource provisioning
- **Ansible** - Configuration management and server automation
- **Docker** - Application containerization with multi-stage builds
- **Kubernetes** - Container orchestration and service mesh
- **Jenkins** - CI/CD pipeline automation with shared libraries
- **ArgoCD** - GitOps-based continuous deployment
- **NGINX** - Reverse proxy, load balancer, and ingress controller

### Cloud Services (AWS)
- **Amazon EKS** - Managed Kubernetes service
- **Amazon ECR** - Container image registry
- **Amazon S3** - Object storage for files and backups
- **Amazon VPC** - Virtual private cloud networking
- **AWS CloudWatch** - Monitoring, logging, and alerting
- **AWS Backup** - Automated backup and disaster recovery
- **Certificate Manager** - SSL/TLS certificate management

### Application Stack (MERN)
- **React 16.12.0** - Frontend user interface library
- **Redux** - State management for React applications
- **Node.js** - JavaScript runtime environment
- **Express.js** - Web application framework
- **MongoDB** - NoSQL document database
- **Mongoose** - MongoDB object document mapper

### Monitoring & Observability
- **AWS CloudWatch** - Metrics collection, logging, and alerting
- **AWS X-Ray** - Distributed tracing and performance insights
- **Trivy** - Container vulnerability scanning
- **Discord Integration** - Real-time notifications and alerts

### Infrastructure Deployment

1. **Provision AWS Infrastructure**
   ```bash
   cd Terraform
   terraform init
   terraform plan
   terraform apply
   ```

2. **Configure Servers with Ansible**
   ```bash
   cd Ansible
   ansible-playbook -i my_inventory.ini roles_playbook.yml
   ```

3. **Deploy to Kubernetes**
   ```bash
   cd k8s
   kubectl apply -f namespace.yaml
   kubectl apply -f .
   ```

4. **Setup GitOps with ArgoCD**
   ```bash
   cd argoCD
   kubectl apply -f application.yaml
   ```

### Local Development

1. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd ITI-Project
   cp .env.example .env
   ```

2. **Start Development Environment**
   ```bash
   docker-compose up -d
   ```

3. **Access Applications**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - MongoDB: localhost:27017

## Deployment Strategies

### Production Deployment on AWS EKS

The project supports multiple deployment strategies:

1. **Blue-Green Deployment** - Zero-downtime deployments with traffic switching
2. **Rolling Updates** - Gradual replacement of application instances
3. **Canary Releases** - Gradual traffic shifting to new versions
4. **GitOps Workflow** - Automated deployment triggered by Git commits

### Infrastructure Automation

- **Terraform Modules** provide reusable infrastructure components
- **Ansible Roles** automate server configuration and software installation
- **Jenkins Pipeline** orchestrates the entire CI/CD workflow
- **ArgoCD** ensures cluster state matches Git repository declarations

## Monitoring & Observability

### Comprehensive Monitoring Stack

- **Application Performance Monitoring** - Response times, error rates, throughput
- **Infrastructure Monitoring** - CPU, memory, disk, network metrics
- **Business Metrics** - User engagement, conversion rates, revenue tracking
- **Security Monitoring** - Vulnerability scanning, compliance checking
- **Log Aggregation** - Centralized logging with AWS CloudWatch

### Alerting & Notifications

- **AWS CloudWatch Alarms** - Intelligent alert routing and infrastructure monitoring
- **Discord Webhooks** - Real-time build and deployment notifications
- **AWS Systems Manager** - Automated operational tasks and notifications
- **CloudWatch Dashboards** - Visual monitoring and trending

## Security Implementation

### Multi-Layer Security Approach

- **Network Security** - VPC isolation, security groups, NACLs
- **Container Security** - Trivy vulnerability scanning, minimal base images
- **Secrets Management** - Kubernetes secrets, AWS Systems Manager
- **SSL/TLS Encryption** - Automated certificate management
- **Access Control** - RBAC for Kubernetes, IAM for AWS resources
- **Compliance** - Security best practices and regular auditing

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- Ansible >= 2.9
- Docker and Docker Compose
- kubectl for Kubernetes management
- Git for version control

#### Continuous Integration
![Continuous Integration](./svg/ci.drawio.svg)

#### Continuous Deployment
![Continuous Deployment](./svg/cd.drawio.svg)

#### Complete CI/CD Workflow
![Complete CI/CD](./svg/Cicd_kh.drawio.svg)

## Project Structure - DevOps Architecture

```
ITI-Project/
├── CI/CD Pipeline & Orchestration
│   ├── Jenkinsfile                     # Declarative Jenkins pipeline with stages
│   ├── sendDiscordNotification.groovy  # Custom notification integration
│   └── docker-compose.yaml             # Local development environment
│
├── Kubernetes Infrastructure (k8s/)
│   ├── Core Application Manifests
│   │   ├── namespace.yaml              # Application namespace isolation
│   │   ├── configmap-secret.yaml       # Environment configuration & secrets
│   │   ├── backend.yaml                # Node.js API deployment & service
│   │   ├── frontend.yaml               # React app deployment & service
│   │   └── mongodb.yaml                # MongoDB StatefulSet with persistence
│   │
│   ├── Network & Security
│   │   ├── ingress.yaml                # NGINX Ingress with SSL termination
│   │   └── cert-manager.yaml           # Automated SSL certificate management
│   │
│   └── GitOps & Monitoring
│       ├── argocd-ingress.yaml         # ArgoCD GitOps UI access
│   ├── GitOps & Monitoring
│   │   ├── monitoring.yaml             # AWS CloudWatch monitoring stack
│   │   └── seed-products-job.yaml      # Database initialization job
│       └── seed-products-job.yaml      # Database initialization job
│
├── Cloud Infrastructure (deployment/)
│   ├── aws/
│   │   ├── amazona-s3-policy.json      # S3 bucket IAM policies
│   │   ├── ecr-repositories.yaml       # Container registry configuration
│   │   └── cloudformation/             # Infrastructure as Code templates
│   │
│   └── eks/
│       ├── cluster-config.yaml         # EKS cluster specifications
│       └── load-balancer.yaml          # AWS load balancer setup
│
├── DevOps Documentation (docs/)
│   ├── Operations Guides
│   │   ├── DEPLOYMENT-SUMMARY.md       # Complete deployment architecture
│   │   ├── KUBERNETES-DEPLOYMENT-GUIDE.md # Production deployment guide
│   │   └── README-AWS-SETUP.md         # Cloud services integration
│   │
│   ├── Troubleshooting & Maintenance
│   │   ├── DEPLOYMENT-CHECKLIST.md     # Pre-deployment validation
│   │   ├── IMAGE-PULL-TROUBLESHOOTING.md # Container issues resolution
│   │   └── MONITORING-SETUP.md         # Observability configuration
│   │
│   └── Reference Materials
│       ├── FEATURE-SUMMARY.md          # Platform capabilities overview
│       └── KEY-CODE-SNIPPETS.js        # Critical implementation patterns
│
├── Architecture Visualization (svg/)
│   ├── cicd.drawio.svg                 # CI/CD pipeline flow
│   ├── infra_aws.drawio.svg            # AWS cloud architecture
│   ├── k8s.drawio.svg                  # Kubernetes cluster topology
│   ├── ci.drawio.svg                   # Continuous integration process
│   ├── cd.drawio.svg                   # Continuous deployment workflow
│   └── Cicd_kh.drawio.svg              # End-to-end DevOps workflow
│
├── Application Containers
│   ├── backend/                        # Node.js/Express API
│   │   ├── Dockerfile                  # Multi-stage production build
│   │   ├── models/                     # Database schemas & models
│   │   ├── routes/                     # RESTful API endpoints
│   │   └── server.js                   # Application entry point
│   │
│   ├── frontend/                       # React SPA
│   │   ├── Dockerfile                  # Optimized production build
│   │   ├── nginx.conf                  # Production web server config
│   │   ├── src/screens/                # React components & pages
│   │   └── public/                     # Static assets
│   │
│   └── template/                       # Static landing pages
│       ├── index.html                  # Marketing page template
│       └── assets/                     # Static resources
│
└── Deployment Configurations
    ├── Procfile                        # Heroku PaaS deployment
    └── .env.example                    # Environment variables template
```

## Technology Stack

### Frontend
- **React 16.12.0** - UI library
- **Redux** - State management
- **React Router** - Client-side routing
- **Axios** - HTTP client
- **Bootstrap** - CSS framework

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MongoDB** - NoSQL database
- **Mongoose** - MongoDB ODM
- **JWT** - Authentication
- **Multer** - File upload handling
- **AWS SDK** - Cloud services integration

### DevOps & Infrastructure
- **Docker** - Multi-stage containerization for both frontend and backend
- **Kubernetes** - Production-ready orchestration with Amazon EKS
- **Jenkins** - Comprehensive CI/CD pipeline with shared libraries
- **ArgoCD** - GitOps-based continuous deployment
- **Prometheus** - Application and infrastructure monitoring
- **Grafana** - Metrics visualization and alerting
- **NGINX** - Reverse proxy, load balancer, and ingress controller
- **Cert-Manager** - Automated SSL/TLS certificate management
- **Discord Integration** - Build notifications and status updates

### Cloud Services & Storage
- **AWS S3** - Scalable file storage for product images
- **AWS ECR** - Container registry for Docker images
- **Amazon EKS** - Kubernetes cluster hosting and management
- **MongoDB** - Primary database (local or Atlas)
- **Persistent Volumes** - Kubernetes persistent storage for data

## Quick Start

### Prerequisites
- Node.js 14+ and npm
- Docker and Docker Compose
- kubectl (for Kubernetes deployment)
- AWS CLI (for cloud deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ITI-Project
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start with Docker Compose**
   ```bash
   docker-compose up -d
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - MongoDB: localhost:27017

### Manual Setup

1. **Backend Setup**
   ```bash
   cd backend
   npm install
   npm start
   ```

2. **Frontend Setup**
   ```bash
   cd frontend
   npm install
   npm start
   ```

## Kubernetes Deployment

### Prerequisites
- DigitalOcean account with billing enabled
- Domain name for SSL certificates
- Local tools: Docker, kubectl, doctl (DigitalOcean CLI)
- AWS account for ECR and S3 services

### Quick Deployment
```bash
# Create DigitalOcean cluster
cd k8s
kubectl apply -f create-cluster.yaml

# Deploy complete application stack
kubectl apply -f .

# Install ArgoCD for GitOps
kubectl apply -f argocd-ingress.yaml

# Populate sample data
kubectl apply -f seed-products-job.yaml

# Test deployment
kubectl get ingress -n ecommerce
```

### Manual Step-by-step Deployment

1. **Create Kubernetes cluster**
   ```bash
   cd k8s
   kubectl apply -f namespace.yaml
   ```

2. **Deploy core infrastructure**
   ```bash
   # Create namespace and basic resources
   kubectl apply -f namespace.yaml
   kubectl apply -f configmap-secret.yaml
   
   # Deploy MongoDB with persistent storage
   kubectl apply -f mongodb.yaml
   ```

3. **Deploy application services**
   ```bash
   # Deploy backend API
   kubectl apply -f backend.yaml
   
   # Deploy frontend React app
   kubectl apply -f frontend.yaml
   ```

4. **Configure ingress and SSL**
   ```bash
   # Install cert-manager for SSL
   kubectl apply -f cert-manager.yaml
   
   # Configure NGINX ingress
   kubectl apply -f ingress.yaml
   ```

5. **Setup monitoring (optional)**
   ```bash
   kubectl apply -f monitoring.yaml
   ```

6. **Verify deployment**
   ```bash
   kubectl get pods -n ecommerce
   kubectl get services -n ecommerce
   kubectl get ingress -n ecommerce
   ```

### ArgoCD GitOps Setup

1. **Install ArgoCD**
   ```bash
   kubectl apply -f argocd-ingress.yaml
   ```

2. **Access ArgoCD UI**
   ```bash
   # Get admin password
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   
   # Port forward to access UI
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

3. **Configure application sync**
   - Access ArgoCD at https://localhost:8080
   - Create new application pointing to your Git repository
   - Set sync policy to automatic

## Configuration

### Environment Variables

#### Backend
```env
MONGODB_URI=mongodb://localhost:27017/amazona
JWT_SECRET=your-jwt-secret
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_REGION=us-east-1
PORT=5000
```

#### Frontend
```env
REACT_APP_API_URL=http://localhost:5000
```

## Monitoring & Observability

The project includes comprehensive monitoring and observability setup:

### Monitoring Stack
- **Prometheus** - Metrics collection and alerting
- **Grafana** - Visualization dashboards and reporting
- **Node Exporter** - System-level metrics
- **kube-state-metrics** - Kubernetes cluster metrics

### Key Metrics
- **Application Metrics**
  - HTTP request rates and response times
  - Database connection pool status
  - User authentication events
  - Shopping cart and order conversion rates
- **Infrastructure Metrics**
  - Pod CPU and memory usage
  - Persistent volume utilization
  - Network traffic and latency
  - Kubernetes cluster health
- **Business Metrics**
  - Active user sessions
  - Product view and purchase rates
  - Revenue tracking
  - Error rates and user experience

### Alerting
- **Performance Alerts** - High response times or error rates
- **Resource Alerts** - CPU/memory/disk usage thresholds
- **Availability Alerts** - Service downtime detection
- **Business Alerts** - Unusual traffic patterns or conversion drops

### Accessing Monitoring
```bash
# Access CloudWatch Dashboard
aws cloudwatch get-dashboard --dashboard-name ecommerce-dashboard

# View application logs
aws logs describe-log-groups --log-group-name-prefix /aws/eks/ecommerce

# Monitor cluster metrics
kubectl top nodes
kubectl top pods -n ecommerce
```

### Log Management
- **Centralized Logging** - Application and system logs with AWS CloudWatch
- **Log Aggregation** - CloudWatch Logs Insights for log analysis
- **Error Tracking** - Structured error logging and automated alerting

## CI/CD Pipeline

The project features a comprehensive Jenkins pipeline with the following stages:

### Pipeline Architecture
- **Shared Library Integration** - Reusable pipeline components from GitLab
- **Multi-Environment Support** - Development, staging, and production deployments
- **Automated Testing** - Unit tests, integration tests, and security scans
- **Discord Notifications** - Real-time build status updates

### Pipeline Stages

1. **Detect Changes** - Identifies modified components (frontend/backend)
2. **Build Stage** 
   - Docker image creation for modified services
   - Multi-stage builds for optimized container sizes
   - Image tagging with build numbers and Git commits
3. **Test Stage**
   - Unit test execution
   - Code quality analysis with ESLint
   - Security vulnerability scanning
4. **Push Stage**
   - Image push to AWS ECR registry
   - Automated manifest updates with new image tags
5. **Deploy Stage**
   - Kubernetes deployment via kubectl
   - ArgoCD sync for GitOps workflows
   - Health checks and rollback capabilities
6. **Notification Stage**
   - Discord webhook integration
   - Build status, duration, and logs reporting
   - Failure alerting and success confirmations

### Jenkins Configuration

```groovy
// Key pipeline features
- Node.js tool integration
- AWS ECR authentication
- Kubernetes cluster access
- Discord webhook notifications
- Conditional deployment based on changes
```

### Deployment Automation

The `k8s/` directory includes comprehensive Kubernetes manifests and configurations:
- Infrastructure provisioning with declarative YAML manifests
- Automated image building and registry management
- Dynamic configuration updates through ConfigMaps and Secrets
- Health monitoring and application validation
- Automated troubleshooting and recovery procedures
- Data validation and seeding capabilities

## Testing

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test

# Integration tests
npm run test:integration

# E2E tests
npm run test:e2e
```

## Documentation

### Comprehensive Guides
- **[Deployment Summary](./docs/DEPLOYMENT-SUMMARY.md)** - Complete deployment overview and architecture
- **[Kubernetes Deployment Guide](./docs/KUBERNETES-DEPLOYMENT-GUIDE.md)** - Step-by-step Kubernetes setup
- **[AWS Configuration Guide](./docs/README-AWS-SETUP.md)** - AWS services integration
- **[Kubernetes Documentation](./docs/README-KUBERNETES.md)** - Detailed Kubernetes configuration
- **[Feature Summary](./docs/FEATURE-SUMMARY.md)** - Automated feature overview documentation
- **[Key Code Snippets](./docs/KEY-CODE-SNIPPETS.js)** - Important code examples and patterns

### Quick Reference
Located in `k8s/` directory:
- **Deployment Checklist** - `DEPLOYMENT-CHECKLIST.md`
- **Troubleshooting Guide** - `IMAGE-PULL-TROUBLESHOOTING.md`
- **Health Check Manifests** - Application monitoring configurations
- **Verification Procedures** - Deployment validation workflows
- **Recovery Procedures** - Automated troubleshooting guides

### Architecture Documentation
Visual diagrams available in `svg/` directory showing:
- Complete CI/CD workflow and pipeline architecture
- Infrastructure overview with AWS integration
- Kubernetes cluster topology and networking
- Continuous integration and deployment processes

## Team

This project was developed by a talented team of DevOps engineers:

- **[khaledhawil](https://github.com/khaledhawil)** - DevOps Engineer
- **[AbdelrahmanElshahat](https://github.com/AbdelrahmanElshahat)** - DevOps Engineer  
- **[MennaHamouda](https://github.com/MennaHamouda)** - DevOps Engineer
- **[alaaelnagy](https://github.com/alaaelnagy)** - DevOps Engineer
- **[saraghonim](https://github.com/saraghonim)** - DevOps Engineer

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or need help:

1. Check the [documentation](./docs/)
2. Search existing [issues](../../issues)
3. Create a new issue with detailed information


---

**ITI Project** - Building modern, scalable e-commerce solutions with cutting-edge DevOps practices.