variable "cluster_name" {
  description = "EKS cluster name for CloudWatch monitoring"
  type        = string
}

variable "jenkins_instance_id" {
  description = "Jenkins EC2 instance ID for CloudWatch monitoring"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 14
}
