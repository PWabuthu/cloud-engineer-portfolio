# Cloud Engineer Portfolio

This portfolio documents my hands-on AWS cloud engineering projects as I build toward cloud security architecture.

My background is in a detail-driven trade where precision, troubleshooting, and clean execution matter. I’m bringing that same mindset into AWS infrastructure by building projects focused on networking, Terraform, IAM, security monitoring, logging, compliance, and operational visibility.

Each project is built, tested, documented, and reviewed so I can explain the architecture, tradeoffs, issues I ran into, and what I would improve in a production environment.

## Projects

| Project | Status | Focus | What It Demonstrates |
|---|---|---|---|
| [01 - AWS Infrastructure Foundation](01-terraform-aws-foundation) | Complete | VPC, public/private subnets, EC2, NAT Gateway, bastion access, IAM, VPC Flow Logs, Terraform | AWS networking fundamentals, access control, private subnet routing, infrastructure visibility, and Terraform-based rebuild |
| [02 - AWS Security Monitoring Baseline](02-aws-security-monitoring) | Complete | CloudTrail, GuardDuty, EventBridge, SNS, AWS Config, S3, IAM, Terraform | Security monitoring, alert routing, severity filtering, compliance validation, security runbook documentation, and operational cleanup lessons |
| Cloud Resume with CI/CD | Planned | S3, CloudFront, Route 53, Lambda, API Gateway, DynamoDB, GitHub Actions, Terraform | Application deployment, serverless backend, CI/CD, and public web hosting |
| Security Automation with Lambda and Python | Planned | Lambda, Python, EventBridge, GuardDuty or AWS Config, SNS | Event-driven security response and automated remediation |
| Multi-Account Landing Zone with Transit Gateway | Future | AWS Organizations, Transit Gateway, inspection VPC, spoke VPCs, Terraform | Advanced AWS networking, segmentation, and enterprise-style cloud architecture |

## Project 1: AWS Infrastructure Foundation

The first project focuses on building a secure AWS network foundation.

I built a custom VPC with public and private subnets, route tables, an Internet Gateway, NAT Gateway, bastion host access, EC2 instances, IAM roles, security groups, and VPC Flow Logs.

I built the environment manually first to understand how the AWS networking pieces behave, then rebuilt it with Terraform to make the infrastructure reproducible and version-controlled.

Key lessons included:

- Public and private subnet behavior depends on route tables, not just subnet names
- Private instances can use a NAT Gateway for outbound access without being directly exposed to the internet
- Bastion access can be used as a controlled entry point for private instances
- VPC Flow Logs provide useful network visibility for troubleshooting
- Terraform makes infrastructure easier to rebuild, review, and destroy safely

Project link: [AWS Infrastructure Foundation](01-terraform-aws-foundation)

## Project 2: AWS Security Monitoring Baseline

The second project builds on the first by focusing on what happens after infrastructure exists.

I used Terraform to deploy a security monitoring baseline with CloudTrail, GuardDuty, EventBridge, SNS, AWS Config, Amazon S3, and IAM.

The project includes:

- CloudTrail logging to a secured S3 bucket
- GuardDuty threat detection
- EventBridge routing with severity filtering
- SNS email alerts
- AWS Config managed rules
- A real AWS Config validation test using a temporary security group open to SSH from `0.0.0.0/0`
- A security runbook documenting triage, investigation, limitations, and cleanup lessons

The strongest part of this project was validation. I generated GuardDuty sample findings to confirm alert delivery, then tuned the alert path after the first version created too much email noise. I also confirmed AWS Config marked an intentionally misconfigured security group as `NON_COMPLIANT`.

Project link: [AWS Security Monitoring Baseline](02-aws-security-monitoring)

## Focus Areas

- AWS infrastructure design
- Terraform and Infrastructure as Code
- VPC networking and routing
- IAM roles and access control
- Cloud security monitoring
- Logging and visibility
- Compliance checks with AWS Config
- Troubleshooting and break/fix documentation
- Architecture diagrams and technical documentation

## Tools and Services Used

- AWS
- Terraform
- Amazon VPC
- Amazon EC2
- IAM
- Amazon S3
- AWS CloudTrail
- Amazon GuardDuty
- Amazon EventBridge
- Amazon SNS
- AWS Config
- VPC Flow Logs
- CloudWatch Logs
- GitHub
- draw.io / diagrams.net

## How This Portfolio Is Built

Each project is organized as a standalone folder with its own documentation, Terraform files, screenshots, and architecture diagram where applicable.

The project folders include:

- README documentation
- Terraform configuration
- Architecture diagrams
- Screenshots and validation evidence
- Notes on troubleshooting and improvements
- Security and operational considerations

## Connect

LinkedIn: https://www.linkedin.com/in/patrickwabuthu

GitHub: https://github.com/PWabuthu