# AWS Infrastructure Foundation

This project focuses on building a secure AWS networking foundation and then refactoring the environment into Terraform to make the infrastructure reproducible.

The environment is built incrementally:

• Phase 1: AWS console build (fundamentals)  
• Phase 2: Refactor into Terraform  
• Phase 3: Add Python automation  
• Phase 4: Add AI-supported documentation review

---

## Why I Built This

I built this environment to better understand how networking and access controls work together inside AWS.

While preparing for the AWS Certified Solutions Architect – Associate exam, I realized that understanding AWS services conceptually is different from actually designing and troubleshooting a working environment. This project allowed me to explore how routing, security groups, IAM roles, and subnet isolation affect real infrastructure behavior.

The goal of this project is to move beyond theoretical knowledge and gain hands-on experience designing and managing AWS infrastructure.

---

## Architecture Overview

The environment includes the following components:

• Custom VPC  
• Public and private subnets  
• Internet Gateway  
• Route tables controlling traffic flow  
• Bastion host for controlled SSH access  
• Private EC2 instance  
• Security groups for access control  
• IAM roles for instance permissions

Traffic flow is designed so that public access is limited while internal resources remain protected within private subnets.

---

## Break / Fix Exercises

During the build process several configuration issues were intentionally diagnosed and resolved.

Examples include:

• Private subnet instances not having internet connectivity due to incorrect route table configuration  
• SSH connection failures caused by incorrect key pair paths or permissions  
• Security group rules preventing bastion-to-private-instance communication

Documenting these issues helped reinforce how routing, security groups, and instance access interact in a real AWS environment.

---

## What I Learned

• How route tables determine traffic flow inside a VPC  
• Why private subnets require NAT or bastion patterns for controlled access  
• How security groups and IAM roles interact to control infrastructure access  
• How small configuration mistakes can break connectivity  
• The importance of understanding infrastructure behavior beyond diagrams

---

## Next Steps

The next phase of this project is refactoring the environment using Terraform so the infrastructure can be deployed and managed as code.

This will make the architecture more reproducible and easier to maintain.
