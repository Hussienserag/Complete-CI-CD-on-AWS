
# ITI E-Commerce Platform - Amazona

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Docker](https://img.shields.io/badge/docker-enabled-blue.svg)]()
[![Kubernetes](https://img.shields.io/badge/kubernetes-ready-326ce5.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

**Information Technology Institute (ITI) - AWS Restart Track Final Project**

A modern, full-stack e-commerce platform built with the MERN stack (MongoDB, Express.js, React, Node.js) and designed for cloud-native deployment with comprehensive DevOps practices including Jenkins CI/CD, ArgoCD GitOps, and Kubernetes orchestration. This project demonstrates advanced DevOps methodologies and cloud-native application deployment strategies.

## Features

### Core E-Commerce Features
- **User Authentication & Authorization** - JWT-based secure authentication with registration and signin
- **Product Catalog** - Complete product management with categories, descriptions, and image uploads
- **Shopping Cart** - Dynamic cart management with add/remove/update quantity functionality
- **Order Management** - Full order processing workflow from cart to payment to fulfillment
- **User Profiles** - Personal account management and order history
- **Admin Dashboard** - Administrative interface for product and order management
- **Payment Integration** - Secure payment processing workflow
- **Shipping Management** - Shipping address and delivery options

### Technical Features
- **Responsive Design** - Mobile-first responsive UI built with React
- **RESTful API** - Well-structured backend API with Express.js
- **File Upload** - AWS S3 integration for product images and file storage
- **Database Management** - MongoDB with Mongoose ODM for data persistence
- **Containerization** - Docker containers for both frontend and backend
- **Kubernetes Deployment** - Production-ready Kubernetes manifests
- **CI/CD Pipeline** - Jenkins automation with Discord notifications
- **GitOps** - ArgoCD for continuous deployment
- **Monitoring** - Prometheus and Grafana integration
- **SSL/TLS** - Automatic certificate management with cert-manager

## Architecture

This project follows a microservices architecture with containerized deployment:

### Architecture Diagrams

#### CI/CD Pipeline
![CI/CD Pipeline](./svg/cicd.drawio.svg)

#### Infrastructure Overview
![Infrastructure](./svg/infra_aws.drawio.svg)

#### Kubernetes Deployment
![Kubernetes](./svg/k8s.drawio.svg)

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
│       ├── monitoring.yaml             # Prometheus & Grafana stack
│       └── seed-products-job.yaml      # Database initialization job
│
├── Cloud Infrastructure (deployment/)
│   ├── aws/
│   │   ├── amazona-s3-policy.json      # S3 bucket IAM policies
│   │   ├── ecr-repositories.yaml       # Container registry configuration
│   │   └── cloudformation/             # Infrastructure as Code templates
│   │
│   └── digitalocean/
│       ├── cluster-config.yaml         # DOKS cluster specifications
│       └── load-balancer.yaml          # Cloud load balancer setup
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
- **Kubernetes** - Production-ready orchestration with DigitalOcean DOKS
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
- **DigitalOcean** - Kubernetes cluster hosting and management
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
# Port forward to access Prometheus
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring

# Port forward to access Grafana
kubectl port-forward svc/grafana 3000:80 -n monitoring

# Default Grafana credentials
Username: admin
Password: admin (change on first login)
```

### Log Management
- **Centralized Logging** - Application and system logs
- **Log Aggregation** - ELK stack integration ready
- **Error Tracking** - Structured error logging and alerting

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