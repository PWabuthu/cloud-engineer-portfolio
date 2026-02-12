# Phase 2 Plan: Terraform Refactor

This plan is intentionally lightweight and may change as I get deeper into Terraform.

## Goal

Refactor the AWS infrastructure I built manually in Phase 1 into Infrastructure as Code using Terraform.

The focus is on recreating the existing architecture accurately before introducing improvements.

## Scope

Included:
- VPC
- Public and private subnets
- Internet Gateway
- Route tables and associations
- Security groups (bastion and application)
- IAM role and instance profile for EC2
- EC2 instances (bastion and private instance)

Excluded (for now):
- NAT Gateway
- Load balancer / Auto Scaling
- Monitoring and alerting
- CI/CD

## Approach

- Mirror the Phase 1 architecture as closely as possible.
- Keep the structure simple at first.
- Use variables for CIDR blocks and instance types.
- Start with local state.
- Validate networking before adding compute.

## Resource Mapping (Phase 1 → Terraform)

| Phase 1 Resource | Terraform Resource |
|-----------------|-------------------|
| VPC | aws_vpc |
| Public subnet | aws_subnet |
| Private subnet | aws_subnet |
| Internet Gateway | aws_internet_gateway |
| Route table | aws_route_table |
| Route association | aws_route_table_association |
| Security groups | aws_security_group |
| IAM role | aws_iam_role |
| IAM instance profile | aws_iam_instance_profile |
| EC2 instances | aws_instance |

## What Success Looks Like

- Terraform recreates the Phase 1 architecture.
- Networking behaves exactly the same.
- SSH access works as expected.
- Infrastructure can be destroyed and recreated cleanly.
- Starting small: VPC first, then subnets, then routing.
