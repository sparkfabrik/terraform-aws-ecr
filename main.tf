# We convert list into maps to produce indexed resources
# The indexed resources prevents re-creation in case of any changes in the list variable
locals {
  repositories_map = { for repository in var.repositories : repository => repository }

  # Generate individual rules for each protected tag pattern.
  # These images are kept indefinitely (high countNumber acts as "never delete")
  tag_protection_rules = [
    for index, pattern in var.protected_tag_patterns : {
      rulePriority = index + 1
      description  = "Keep images tagged with ${pattern} indefinitely"
      selection = {
        tagStatus      = "tagged"
        tagPatternList = [pattern]
        countType      = "imageCountMoreThan"
        countNumber    = 9999
      }
      action = {
        type = "expire"
      }
    }
  ]
  
  cleanup_rules = [
    # Rule to clean up old untagged images by time
    {
      rulePriority = length(var.protected_tag_patterns) + 1
      description  = "Remove untagged images older than ${var.ecr_lifecycle_untagged_expiration_days} days"
      selection = {
        tagStatus   = "untagged"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = var.ecr_lifecycle_untagged_expiration_days
      }
      action = {
        type = "expire"
      }
    },
    # Rule to clean up tagged images by time
    {
      rulePriority = length(var.protected_tag_patterns) + 2
      description  = "Remove tagged images older than ${var.ecr_lifecycle_tagged_expiration_days} days"
      selection = {
        tagStatus   = "tagged"
        tagPatternList = ["*"]
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = var.ecr_lifecycle_tagged_expiration_days
      }
      action = {
        type = "expire"
      }
    },
  ]
}

resource "aws_ecr_repository" "repository" {
  for_each = local.repositories_map

  name = each.value

  tags = var.aws_tags
}

resource "aws_ecr_lifecycle_policy" "project_image" {
  for_each = var.enable_ecr_lifecycle_policy ? {
    for repo_name, repo_config in aws_ecr_repository.repository : repo_name => repo_config
    if !contains(var.ecr_lifecycle_policy_excluded_repositories, repo_name)
  } : {}

  repository = each.value.name

  policy = jsonencode({
    rules = concat(
      local.tag_protection_rules,
      local.cleanup_rules
    )
  })
}
