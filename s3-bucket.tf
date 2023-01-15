module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-bench-buckt-${random_string.suffix.result}"
  acl    = "private"

  versioning = {
    enabled = false
  }

}