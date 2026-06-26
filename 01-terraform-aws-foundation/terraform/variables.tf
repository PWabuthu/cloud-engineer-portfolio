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
  description = "Your public IP address allowed to SSH into the bastion host. Use /32."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for bastion and private instances"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in this AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances in us-east-1"
  type        = string
}
