output "frontend_repository_url" {
  description = "ECR frontend repository URL"
  value       = aws_ecrpublic_repository.ITI_project_frontend.repository_uri
}

output "backend_repository_url" {
  description = "ECR backend repository URL"
  value       = aws_ecrpublic_repository.ITI_project_backend.repository_uri
}

output "frontend_repository_name" {
  description = "ECR frontend repository name"
  value       = aws_ecrpublic_repository.ITI_project_frontend.repository_name
}

output "backend_repository_name" {
  description = "ECR backend repository name"
  value       = aws_ecrpublic_repository.ITI_project_backend.repository_name
}
