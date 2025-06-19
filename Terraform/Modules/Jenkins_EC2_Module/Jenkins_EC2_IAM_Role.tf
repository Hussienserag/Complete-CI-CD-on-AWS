resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "jenkins-ec2-role"
    Purpose     = "Jenkins-CICD-ECR-EKS-S3-access"
    Environment = "Production"
    Project     = "ITI-E-Commerce"
  }
}

# CloudWatch Logs Access
resource "aws_iam_role_policy_attachment" "jenkins_ec2_cloudwatch_logs" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# ECR Access for pushing/pulling Docker images
resource "aws_iam_role_policy_attachment" "jenkins_ec2_ecr_full_access" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# EKS Access for managing Kubernetes deployments
resource "aws_iam_role_policy_attachment" "jenkins_ec2_eks_cluster_policy" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "jenkins_ec2_eks_worker_node_policy" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# EKS Service Policy for managing EKS resources
resource "aws_iam_role_policy_attachment" "jenkins_ec2_eks_service_policy" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# S3 Full Access for artifacts, logs, and storage
resource "aws_iam_role_policy_attachment" "jenkins_ec2_s3_full_access" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# EC2 Container Registry Public for public repositories
resource "aws_iam_role_policy_attachment" "jenkins_ec2_ecr_public_full_access" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess"
}

# Custom policy for additional EKS and Kubernetes permissions
resource "aws_iam_policy" "jenkins_eks_additional_policy" {
  name        = "jenkins-eks-additional-policy"
  description = "Additional permissions for Jenkins to manage EKS and Kubernetes resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:DescribeNodegroup",
          "eks:DescribeUpdate",
          "eks:ListClusters",
          "eks:ListNodegroups",
          "eks:ListUpdates",
          "eks:ListFargateProfiles",
          "eks:DescribeFargateProfile",
          "eks:TagResource",
          "eks:UntagResource",
          "eks:ListTagsForResource"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole",
          "iam:GetRole",
          "iam:ListRoles",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "jenkins-eks-additional-policy"
    Purpose     = "Additional-EKS-K8s-permissions-for-Jenkins"
    Environment = "Production"
    Project     = "ITI-E-Commerce"
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_ec2_eks_additional_policy" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_eks_additional_policy.arn
}

# Custom policy for Kubernetes and Docker operations
resource "aws_iam_policy" "jenkins_kubernetes_docker_policy" {
  name        = "jenkins-kubernetes-docker-policy"
  description = "Permissions for Jenkins to manage Kubernetes deployments and Docker operations"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchDeleteImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:CreateRepository",
          "ecr:DeleteRepository"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr-public:GetAuthorizationToken",
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:GetDownloadUrlForLayer",
          "ecr-public:BatchGetImage",
          "ecr-public:PutImage",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload",
          "ecr-public:DescribeRepositories",
          "ecr-public:ListImages",
          "ecr-public:DescribeImages",
          "ecr-public:CreateRepository",
          "ecr-public:DeleteRepository"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObjectVersion",
          "s3:PutObjectAcl",
          "s3:GetObjectAcl",
          "s3:CreateBucket",
          "s3:DeleteBucket"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "jenkins-kubernetes-docker-policy"
    Purpose     = "K8s-and-Docker-operations-for-Jenkins"
    Environment = "Production"
    Project     = "ITI-E-Commerce"
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_ec2_kubernetes_docker_policy" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_kubernetes_docker_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_ec2_instance_profile" {
  name = "jenkins-ec2-instance-profile"
  role = aws_iam_role.jenkins_ec2_role.name

  tags = {
    Name        = "jenkins-ec2-instance-profile"
    Purpose     = "Jenkins-EC2-instance-profile-with-full-CICD-permissions"
    Environment = "Production"
    Project     = "ITI-E-Commerce"
  }
}