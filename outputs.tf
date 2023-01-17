output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "registry_url" {
  value = module.public_ecr.repository_url
}

output "bucket_name" {
  value = module.s3_bucket.s3_bucket_arn
}

output "s3_user" {
  value = aws_iam_user.s3bench.name
}

output "s3_user_key" {
  value     = aws_iam_access_key.s3bench.id
  sensitive = true
}

output "s3_user_access_key" {
  value     = aws_iam_access_key.s3bench.secret
  sensitive = true
}