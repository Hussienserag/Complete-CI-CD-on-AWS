terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    }
    # Using local backend instead of S3 for simplicity
    # If you want to use S3 backend later, uncomment and configure below:
    # backend "s3" {
    #   bucket         = "your-terraform-state-bucket"
    #   key            = "terraform.tfstate"
    #   region         = "us-east-1"
    #   dynamodb_table = "terraform-state-lock"
    # }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Project     = "ITI-E-Commerce"
      Environment = "Production"
      Owner       = "DevOps-Team"
      Terraform   = "true"
    }
  }
}

