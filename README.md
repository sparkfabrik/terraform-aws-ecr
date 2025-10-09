# Terraform AWS ECR

This Terraform module creates and manages Amazon Elastic Container Registry (ECR) repositories with automated lifecycle policies for image cleanup.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | Optional additional AWS tags | `map(string)` | `{}` | no |
| <a name="input_ecr_lifecycle_policy_excluded_repositories"></a> [ecr\_lifecycle\_policy\_excluded\_repositories](#input\_ecr\_lifecycle\_policy\_excluded\_repositories) | A list of ECR repository names to exclude from the default lifecycle policy. | `list(string)` | `[]` | no |
| <a name="input_ecr_lifecycle_tagged_expiration_days"></a> [ecr\_lifecycle\_tagged\_expiration\_days](#input\_ecr\_lifecycle\_tagged\_expiration\_days) | Number of days after which tagged images expire. Only applies if enable\_ecr\_lifecycle\_policy is true. | `number` | `90` | no |
| <a name="input_ecr_lifecycle_untagged_expiration_days"></a> [ecr\_lifecycle\_untagged\_expiration\_days](#input\_ecr\_lifecycle\_untagged\_expiration\_days) | Number of days after which untagged images expire. Only applies if enable\_ecr\_lifecycle\_policy is true. | `number` | `45` | no |
| <a name="input_enable_ecr_lifecycle_policy"></a> [enable\_ecr\_lifecycle\_policy](#input\_enable\_ecr\_lifecycle\_policy) | Enable lifecycle policy for ECR repositories. | `bool` | `true` | no |
| <a name="input_protected_tag_patterns"></a> [protected\_tag\_patterns](#input\_protected\_tag\_patterns) | List of tag patterns to keep indefinitely in ECR lifecycle policy. | `list(string)` | <pre>[<br/>  "latest",<br/>  "main",<br/>  "master",<br/>  "stage",<br/>  "prod*",<br/>  "dev*",<br/>  "review*",<br/>  "*.*",<br/>  "v*.*"<br/>]</pre> | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arns"></a> [arns](#output\_arns) | n/a |
| <a name="output_registry_ids"></a> [registry\_ids](#output\_registry\_ids) | n/a |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.project_image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Modules

No modules.

<!-- END_TF_DOCS -->
