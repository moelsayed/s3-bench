resource "random_string" "bucket" {
  lower= true
  length=8
  special =false
}
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-bench-buckt-${random_string.bucket.result}"
  acl    = "private"

  versioning = {
    enabled = false
  }

}