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

output "guardduty_detector_id" {
  description = "GuardDuty detector ID"
  value       = aws_guardduty_detector.main.id
}

output "security_alerts_topic_arn" {
  description = "SNS topic ARN for security alerts"
  value       = aws_sns_topic.security_alerts.arn
}

output "guardduty_event_rule_name" {
  description = "EventBridge rule used for GuardDuty findings"
  value       = aws_cloudwatch_event_rule.guardduty_findings.name
}

output "config_log_bucket" {
  description = "S3 bucket used for AWS Config delivery"
  value       = aws_s3_bucket.config_logs.id
}

output "config_recorder_name" {
  description = "AWS Config recorder name"
  value       = aws_config_configuration_recorder.main.name
}

output "config_rules" {
  description = "AWS Config managed rules created for this project"
  value = [
    aws_config_config_rule.s3_bucket_public_read_prohibited.name,
    aws_config_config_rule.incoming_ssh_disabled.name,
    aws_config_config_rule.root_account_mfa_enabled.name
  ]
}