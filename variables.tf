variable "repositories" {
  type = list(string)
}

variable "aws_tags" {
  type        = map(string)
  default     = {}
  description = "Optional additional AWS tags"
}


variable "protected_tag_patterns" {
  type        = list(string)
  description = "List of tag patterns to keep indefinitely in ECR lifecycle policy."
  default     = [
    "latest",
    "main", 
    "master",
    "stage",
    "prod*", 
    "dev*", 
    "review*",
    "*.*",     # Semantic versioning pattern (e.g., 1.31, 10.5.2)
    "v*.*"     # Versioned semantic versioning pattern (e.g., v1.2, v10.5.2)
  ]
}

variable "enable_ecr_lifecycle_policy" {
  type        = bool
  description = "Enable lifecycle policy for ECR repositories."
  default     = true
}

variable "ecr_lifecycle_untagged_expiration_days" {
  type        = number
  description = "Number of days after which untagged images expire. Only applies if enable_ecr_lifecycle_policy is true."
  default     = 30
}

variable "ecr_lifecycle_tagged_expiration_days" {
  type        = number
  description = "Number of days after which tagged images expire. Tags matching protected_tag_patterns are never expired. Only applies if enable_ecr_lifecycle_policy is true."
  default     = 30
}

variable "ecr_lifecycle_policy_excluded_repositories" {
  description = "A list of ECR repository names to exclude from the default lifecycle policy."
  type        = list(string)
  default     = []
}
