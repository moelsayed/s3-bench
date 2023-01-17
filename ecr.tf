# https://registry.terraform.io/modules/terraform-aws-modules/ecr/aws/latest#public-repository

module "public_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "s3-bench"
  repository_type = "private"

  repository_read_write_access_arns = ["${data.aws_caller_identity.current.arn}"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  public_repository_catalog_data = {
    description       = "Docker container for s3-bench"
    operating_systems = ["Linux"]
    architectures     = ["x86"]
  }

  tags = {
    Terraform = "true"
  }
}