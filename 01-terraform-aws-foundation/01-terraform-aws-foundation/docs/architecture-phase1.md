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
- Internet Gateway: project1-igw attached to project1-vpc
- Public route table: project1-public-rt
- Route: 0.0.0.0/0 → Internet Gateway
- Associated subnet: project1-public-subnet only

I learned that a subnet is considered public only when it has a route to an Internet Gateway. Simply naming a subnet “public” does not provide internet access.


## Security Groups

**Bastion Security Group**
- Allows SSH (port 22) from my IP only
- Used to restrict public access to a single entry point

**Application Security Group**
- Allows SSH (port 22) only from the bastion security group
- Prevents direct access from the internet

This setup limits public exposure and enforces access through a controlled entry point.


## IAM

I created an IAM role for EC2 instances instead of using static access keys.

- Role name: project1-ec2-role
- Policy attached: AmazonSSMManagedInstanceCore

Using IAM roles allows instances to access AWS services securely without embedding credentials.


## Break / Fix Exercise
### Issue 1: Subnet had no internet access

**What I was trying to do**  
Understand how public internet access is provided to AWS subnets.

**What wasn’t working**  
Even after creating an Internet Gateway, the subnet still had no internet access.

**Initial assumptions**  
I initially assumed attaching an Internet Gateway to the VPC automatically made the subnet public.

**What I discovered**  
The route table with a route to the Internet Gateway was not associated with any subnet.

**The fix**  
I associated the public route table with the public subnet.

**What I learned**  
A subnet is only public when its route table sends internet traffic to an Internet Gateway.


###Issue 2: Unable to SSH into bastion host due to key file error

**What I was trying to do**  
Connect to the bastion EC2 instance using SSH from my local machine.

**What wasn’t working**  
The SSH connection failed with warnings that the identity file could not be found, followed by a “Permission denied (publickey)” error.

**Initial assumptions**  
I initially thought the issue might be related to the security group or network routing since this was my first SSH attempt to the instance.

**What I discovered**  
The `.pem` key file was not in my current working directory, so SSH could not locate it. Because no valid key was provided, AWS rejected the authentication attempt.

**The fix**  
I located the key file on my local machine, referenced it using the full file path in the SSH command, and updated its permissions using `chmod 400` as required by AWS.

**Result**  
After correcting the key path and permissions, I was able to successfully SSH into the bastion host.

**What I learned**  
SSH access issues are often caused by local key file path or permission problems rather than AWS networking or security group misconfigurations. Verifying local setup early can save time when troubleshooting.


