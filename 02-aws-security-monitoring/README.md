# AWS Security Monitoring Baseline

This is the follow-up to my networking project. That project was about building the environment: VPC, subnets, Terraform, NAT Gateway, bastion access, and VPC Flow Logs. This one is about monitoring what happens inside an AWS account.

I’m setting up a basic account monitoring baseline using CloudTrail, GuardDuty, AWS Config, SNS, EventBridge, and CloudWatch. The goal is to log account activity, detect suspicious behavior, catch risky configurations, and send alerts when something needs attention.

## Project Status

- Project folder created
- Terraform base files created
- CloudTrail setup in progress
- GuardDuty, AWS Config, SNS alerts, and runbook still to come

## Planned AWS Services

- AWS CloudTrail
- Amazon S3
- Amazon GuardDuty
- Amazon SNS
- Amazon EventBridge
- AWS Config
- Amazon CloudWatch
- IAM

## Architecture Overview

CloudTrail will log account activity and send the logs to a secured S3 bucket.

GuardDuty will be enabled for threat detection. When GuardDuty creates a finding, EventBridge will route the event to an SNS topic so an email alert can be sent.

AWS Config will check for configuration issues like public S3 buckets and security groups that allow too much inbound access.

I’m also writing a security runbook alongside this project: how I would triage a finding, what I would check first, and what remediation might look like. Not because anyone is asking for it, but because “I’d know what to do” is not the same as having it written down.

## Why I Built This

The networking project was about building infrastructure. This project is about knowing what is happening inside the AWS account.

It is not enough to have a clean VPC if I cannot tell who changed something, whether GuardDuty flagged an issue, or if a security group is open to the internet and I have not noticed yet.

That is the gap this project is meant to close: using AWS security tooling to answer those questions instead of just knowing the theory.