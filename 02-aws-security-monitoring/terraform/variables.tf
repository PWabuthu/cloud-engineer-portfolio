variable "aws_region" {
  description = "AWS region used for the security monitoring baseline"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for tagging AWS resources"
  type        = string
  default     = "security-monitoring"
}

variable "alert_email" {
  description = "Email address used for security alerts"
  type        = string
  default     = ""
}