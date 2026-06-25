# Terraform Rebuild

This folder contains the Terraform code for rebuilding the AWS infrastructure I first built manually in the AWS Console.

I started with the manual build because I wanted to understand how the network worked before turning it into code. After the environment was working, I terminated the AWS resources to keep costs down. Now I’m rebuilding the same architecture with Terraform so it can be recreated in a cleaner and more repeatable way.

The rebuild will start with the core network pieces:

* VPC
* Public and private subnets
* Internet Gateway
* Route tables
* NAT Gateway
* Security groups
* EC2 instances
* IAM roles
* VPC Flow Logs

This phase is also helping me connect what I learned in Terraform training to something I already built by hand.

The goal is not just to write Terraform files. The goal is to understand how each Terraform resource maps back to the AWS architecture and why it needs to exist.
