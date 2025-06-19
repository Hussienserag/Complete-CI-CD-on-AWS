# CloudWatch Log Groups for EKS
resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "eks-cluster-logs"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

# CloudWatch Log Groups for Jenkins
resource "aws_cloudwatch_log_group" "jenkins_logs" {
  name              = "/aws/ec2/jenkins"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "jenkins-logs"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

# CloudWatch Dashboard for monitoring
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "ITI-DevOps-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EKS", "cluster_failed_request_count", "ClusterName", var.cluster_name],
            [".", "cluster_request_total", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "EKS Cluster Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.jenkins_instance_id],
            [".", "DiskSpaceUtilization", ".", ".", "MountPath", "/"],
            [".", "MemoryUtilization", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Jenkins Server Metrics"
          period  = 300
        }
      }
    ]
  })
}

# CloudWatch Alarms for EKS
resource "aws_cloudwatch_metric_alarm" "eks_high_cpu" {
  alarm_name          = "eks-nodes-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EKS nodes CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = var.cluster_name
  }

  tags = {
    Name        = "eks-high-cpu-alarm"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

# CloudWatch Alarms for Jenkins
resource "aws_cloudwatch_metric_alarm" "jenkins_high_cpu" {
  alarm_name          = "jenkins-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors Jenkins server CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = var.jenkins_instance_id
  }

  tags = {
    Name        = "jenkins-high-cpu-alarm"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alerts"

  tags = {
    Name        = "cloudwatch-alerts"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}
