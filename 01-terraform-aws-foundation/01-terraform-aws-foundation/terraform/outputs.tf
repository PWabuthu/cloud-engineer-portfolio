output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.project1.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.project1.cidr_block
}
