resource "random_string" "bucket" {
  upper   = false
  length  = 8
  special = false
}
module "s3_bucket" {
  depends_on = [
    random_string.bucket
  ]
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-bench-buckt-${random_string.bucket.result}"
  acl    = "private"

  versioning = {
    enabled = false
  }

}