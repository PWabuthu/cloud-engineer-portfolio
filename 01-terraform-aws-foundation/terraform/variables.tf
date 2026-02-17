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

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the bastion host (your public IP /32)"
  type        = string
  default     = "0.0.0.0/0"
}
