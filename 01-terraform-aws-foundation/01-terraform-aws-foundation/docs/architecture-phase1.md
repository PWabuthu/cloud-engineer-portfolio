# Project 1 — AWS Infrastructure Foundation
## Phase 1: AWS Console Build

This document captures architecture decisions, issues encountered, and lessons learned while building the AWS foundation using core services before introducing automation.


## Goal


## Architecture Summary

## VPC
- Name: project1-vpc
- CIDR block: 10.0.0.0/16

I created a custom VPC instead of using the default VPC so I could fully control networking and routing as the environment grows.


## Subnets
- Public subnet: project1-public-subnet (10.0.1.0/24)
- Private subnet: project1-private-subnet (10.0.2.0/24)

I split the network into public and private subnets to control exposure. The public subnet will later host a bastion host, while the private subnet will be used for internal workloads.


## Internet Gateway and Routing


## Security Groups


## IAM


## Break / Fix Exercise


## What I Learned
