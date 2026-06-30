# Phase 2 Plan: Terraform Rebuild

This was the original plan for rebuilding the Phase 1 environment in Terraform.

I kept the plan lightweight on purpose — at this stage I didn't want to overcomplicate things, just recreate the core networking in code first.

Some of this changed as I went. The final rebuild went further than the original scope — I ended up adding a NAT Gateway, a second private subnet, a second private EC2 instance, and a cleaner multi-AZ layout.

---

## Goal

Rebuild the Phase 1 infrastructure in Terraform. The point was to take the networking I'd already built by hand and turn it into code I could version, review, destroy, and recreate.

I wasn't trying to get the architecture perfect on the first pass — I just wanted the Terraform to map closely enough to the console build that I could trace how each resource matched what I'd already done.

## Original Scope

First pass covered:

- VPC
- Public and private subnets
- Internet Gateway
- Route tables and associations
- Security groups for bastion and private instances
- IAM role and instance profile for EC2
- EC2 instances for bastion and private workloads

NAT Gateway, monitoring, load balancing, Auto Scaling, and CI/CD were left out on purpose so the rebuild stayed manageable.

## What Changed

As the architecture got clearer, the rebuild grew past the original plan. The final version included:

- Custom VPC
- Two public subnets, two private subnets
- Internet Gateway
- Public route table
- NAT Gateway
- Private route table
- Bastion security group
- Private instance security group
- Bastion host
- Two private EC2 instances
- IAM role and instance profile

The main change was pulling the NAT Gateway and multi-AZ layout in earlier than planned, since it lined up better with where the architecture was actually heading.

## Approach

I built it in layers instead of trying to write it all at once:

1. Provider and Terraform version
2. VPC
3. Public and private subnets
4. Internet Gateway and public routing
5. NAT Gateway and private routing
6. Security groups
7. IAM role and instance profile
8. EC2 instances
9. Outputs for validation

Going layer by layer kept me from losing track of what each file was actually doing.

## Resource Mapping

| Architecture Component | Terraform Resource |
|---|---|
| VPC | `aws_vpc` |
| Public subnets | `aws_subnet` |
| Private subnets | `aws_subnet` |
| Internet Gateway | `aws_internet_gateway` |
| Public route table | `aws_route_table` |
| Private route table | `aws_route_table` |
| Route table associations | `aws_route_table_association` |
| NAT Gateway | `aws_nat_gateway` |
| Elastic IP for NAT Gateway | `aws_eip` |
| Security groups | `aws_security_group` |
| IAM role | `aws_iam_role` |
| IAM instance profile | `aws_iam_instance_profile` |
| EC2 instances | `aws_instance` |

## Validation

Tested locally with the standard workflow:

```text
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy