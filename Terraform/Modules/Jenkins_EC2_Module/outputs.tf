# Jenkins EC2 Module Outputs

output "Jenkins_public_ip" {
  description = "Public IP address of Jenkins EC2 instance"
  value       = aws_instance.Jenkins_Ec2.public_ip
}

output "Jenkins_private_ip" {
  description = "Private IP address of Jenkins EC2 instance"
  value       = aws_instance.Jenkins_Ec2.private_ip
}

output "EC2_Jenkins_id" {
  description = "Instance ID of Jenkins EC2"
  value       = aws_instance.Jenkins_Ec2.id
}

output "my_key" {
  description = "SSH key pair name for Jenkins EC2"
  value       = aws_key_pair.my_key_pair.key_name
}

output "jenkins_instance_profile_arn" {
  description = "ARN of Jenkins EC2 instance profile"
  value       = aws_iam_instance_profile.jenkins_ec2_instance_profile.arn
}

output "jenkins_iam_role_arn" {
  description = "ARN of Jenkins IAM role"
  value       = aws_iam_role.jenkins_ec2_role.arn
}

output "jenkins_iam_role_name" {
  description = "Name of Jenkins IAM role"
  value       = aws_iam_role.jenkins_ec2_role.name
}

output "jenkins_security_group_id" {
  description = "Security group ID attached to Jenkins instance"
  value       = tolist(aws_instance.Jenkins_Ec2.vpc_security_group_ids)[0]
}

output "jenkins_subnet_id" {
  description = "Subnet ID where Jenkins instance is deployed"
  value       = aws_instance.Jenkins_Ec2.subnet_id
}

output "jenkins_private_key_path" {
  description = "Path to Jenkins private key file"
  value       = local_file.private_key.filename
}

output "jenkins_public_key_path" {
  description = "Path to Jenkins public key file" 
  value       = local_file.public_key.filename
}

# IAM Policy ARNs for reference
output "jenkins_custom_policies" {
  description = "Custom IAM policies created for Jenkins"
  value = {
    eks_additional_policy      = aws_iam_policy.jenkins_eks_additional_policy.arn
    kubernetes_docker_policy   = aws_iam_policy.jenkins_kubernetes_docker_policy.arn
  }
}

output "jenkins_managed_policies" {
  description = "AWS managed policies attached to Jenkins role"
  value = [
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", 
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess"
  ]
}
