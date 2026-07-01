# Terraform Rebuild

This folder has the Terraform code for rebuilding the AWS infrastructure I originally built by hand in the console.

I started manually because I wanted to actually understand how the network pieces fit together before writing any code. Once the manual environment was working, I terminated the resources to avoid ongoing costs. This is the same core architecture rebuilt in Terraform so I can spin it up and tear it down without redoing everything by hand.

The current Terraform code creates:

* VPC
* Public and private subnets across two Availability Zones
* Internet Gateway
* Public and private route tables
* NAT Gateway
* Security groups
* Bastion Host
* Private EC2 instances
* IAM role and instance profile for EC2

Building it this way forces me to map every Terraform resource back to something I already built manually, so I am not just copying syntax. I know what each block is doing in the network.

## Tested Workflow

I tested the rebuild locally with `init`, `validate`, `plan`, and `apply`, then ran `destroy` right after to avoid leaving the NAT Gateway and EC2 instances running and creating charges. Terraform created everything cleanly and tore it down without issues.

```text
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

## File Breakdown

* `versions.tf` — Terraform and AWS provider version constraints
* `provider.tf` — AWS provider and region config
* `variables.tf` — inputs like VPC CIDR, key pair name, AMI ID, instance type, and allowed SSH CIDR
* `main.tf` — VPC, subnets, route tables, NAT Gateway, security groups
* `ec2.tf` — bastion host and private EC2 instances
* `iam.tf` — IAM role and instance profile for EC2
* `outputs.tf` — VPC ID, subnet IDs, NAT Gateway ID, instance IPs

## Local Variables

This project uses a local `terraform.tfvars` file for values that should not be committed to GitHub, like my public IP address and key pair name. It is included in `.gitignore`.

Example:

```hcl
key_name         = "your-key-pair-name"
ami_id           = "your-ami-id"
ssh_allowed_cidr = "your-public-ip/32"
```

