output "arns" {
  value = toset([for repo in aws_ecr_repository.repository : repo.arn])
}

output "registry_ids" {
  value = toset([for repo in aws_ecr_repository.repository : repo.registry_id])
}

output "repository_urls" {
  value = toset([for repo in aws_ecr_repository.repository : repo.repository_url])
}
