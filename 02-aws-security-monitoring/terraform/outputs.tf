output "project_name" {
  description = "Project name used for resource naming"
  value       = var.project_name
}

output "aws_region" {
  description = "AWS region used for this project"
  value       = var.aws_region
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  value       = aws_cloudtrail.main.name
}

output "cloudtrail_log_bucket" {
  description = "S3 bucket used for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_logs.id
}