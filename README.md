
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

## Team

This comprehensive DevOps project was developed by a talented team of engineers:

- **[khaledhawil](https://github.com/khaledhawil)** - DevOps Engineer & Infrastructure Architect
- **[AbdelrahmanElshahat](https://github.com/AbdelrahmanElshahat)** - DevOps Engineer & CI/CD Specialist
- **[MennaHamouda](https://github.com/MennaHamouda)** - DevOps Engineer & Kubernetes Expert
- **[alaaelnagy](https://github.com/alaaelnagy)** - DevOps Engineer & Monitoring Specialist
- **[saraghonim](https://github.com/saraghonim)** - DevOps Engineer & Security Specialist

## Monitoring & Observability

The project includes comprehensive monitoring and observability setup:

### Monitoring Stack
- **Prometheus** - Metrics collection and alerting
## Contributing

We welcome contributions to improve this DevOps demonstration project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/enhancement`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/enhancement`)
5. Open a Pull Request with detailed description

## Documentation

### Comprehensive Guides
- **[Deployment Architecture](./docs/DEPLOYMENT-SUMMARY.md)** - Complete infrastructure overview
- **[Kubernetes Setup Guide](./docs/KUBERNETES-DEPLOYMENT-GUIDE.md)** - Production deployment steps
- **[AWS Configuration](./docs/README-AWS-SETUP.md)** - Cloud services integration
- **[Platform Features](./docs/FEATURE-SUMMARY.md)** - Capabilities and functionality overview

### Quick Reference
- **[Deployment Checklist](./k8s/DEPLOYMENT-CHECKLIST.md)** - Pre-deployment validation
- **[Troubleshooting Guide](./k8s/IMAGE-PULL-TROUBLESHOOTING.md)** - Common issues resolution
- **[Code Examples](./docs/KEY-CODE-SNIPPETS.js)** - Implementation patterns

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Contact

For technical support or questions about this DevOps implementation:

1. Review the comprehensive [documentation](./docs/)
2. Check existing [issues](../../issues) for solutions
3. Create a new issue with detailed information and logs
4. Contact the development team through GitHub

---

**ITI Project 2025** - Demonstrating enterprise-grade DevOps practices for modern cloud-native applications.