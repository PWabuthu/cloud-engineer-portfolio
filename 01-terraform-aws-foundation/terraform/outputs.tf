output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.project1.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.project1.cidr_block
}

output "public_subnet_a_id" {
  description = "ID of Public Subnet A"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "ID of Public Subnet B"
  value       = aws_subnet.public_b.id
}

output "private_subnet_a_id" {
  description = "ID of Private Subnet A"
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "ID of Private Subnet B"
  value       = aws_subnet.private_b.id
}

output "bastion_public_ip" {
  description = "Public IP address of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "private_instance_a_private_ip" {
  description = "Private IP address of Private EC2 Instance A"
  value       = aws_instance.private_a.private_ip
}

output "private_instance_b_private_ip" {
  description = "Private IP address of Private EC2 Instance B"
  value       = aws_instance.private_b.private_ip
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "vpc_flow_log_id" {
  description = "ID of the VPC Flow Log"
  value       = aws_flow_log.vpc_flow_logs.id
}

output "vpc_flow_log_group_name" {
  description = "CloudWatch Log Group used for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}