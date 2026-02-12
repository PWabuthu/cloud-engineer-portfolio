variable "project_name" {
  description = "Name prefix used for tagging AWS resources"
  type        = string
  default     = "project1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
