# Phase 1: Manual AWS Console Build

This is the original manual build for Project 1, before I rebuilt it in Terraform.

I did the first version by hand in the console because I wanted to actually understand the networking before turning it into code. This phase covered VPC routing, public vs. private subnet behavior, bastion access, security groups, and IAM roles.

The architecture has grown a lot since then. The current design is in the main `README.md`.

---

## Original Goal

Build a small AWS networking foundation by hand and troubleshoot it directly in the console. I wanted to actually understand:

* how a custom VPC is structured
* what makes a subnet public or private
* how route tables control traffic flow
* how a bastion host reaches private instances
* how security groups control access between resources
* why IAM roles are better than hardcoding credentials on an EC2 instance

## Original Architecture

The first version was small on purpose:

* Custom VPC
* One public subnet, one private subnet
* Internet Gateway
* Public route table
* Bastion host
* Private EC2 instance
* Security groups
* IAM role for EC2

I kept it minimal so I could understand the foundation before piling on more pieces.

### VPC

`project1-vpc`, CIDR `10.0.0.0/16`. I used a custom VPC instead of the default one so I'd control the network design from the start.

### Subnets

* Public: `project1-public-subnet` — `10.0.1.0/24`
* Private: `project1-private-subnet` — `10.0.2.0/24`

This was just meant to get the basic public/private behavior down. Later I expanded it into a multi-AZ design with public and private subnets in two AZs.

### Internet Gateway and Routing

* IGW: `project1-igw`
* Public route table: `project1-public-rt`, with `0.0.0.0/0` → IGW
* Associated with the public subnet only

Biggest lesson here: a subnet isn't public because of its name. It's public because its route table sends internet-bound traffic to an IGW.

### Security Groups

The bastion SG allowed SSH from my IP only — it was the one controlled entry point into the environment.

The private instance SG allowed SSH only from the bastion SG, so it was never directly reachable from the internet.

### IAM

Used an IAM role (`project1-ec2-role`, `AmazonSSMManagedInstanceCore`) instead of static access keys. This helped me understand why instances should get permissions through an AWS-managed identity rather than long-term credentials stored on the instance.

## Break/Fix Notes

**Subnet had no internet access.** Even after attaching an IGW to the VPC, the subnet still wasn't reaching the internet. I assumed attaching the IGW to the VPC was enough — it isn't. The route table with the IGW route was never associated with the subnet. Fixed by associating it. Lesson: public/private comes down to routing, not just having an IGW in the VPC.

**Bastion could reach the private instance, but SSH auth failed.** Connection got there fine, but I hit `Permission denied (publickey)`. First guess was a security group or subnet problem. Turned out networking was fine — the bastion just didn't have the private key to authenticate into the private instance. Fixed it with agent forwarding (`ssh -A`) so my local key could be used without copying it onto the bastion. Lesson: if SSH reaches the instance but fails on the key, it's an auth problem, not a networking one — and agent forwarding is better than storing keys on a jump box.

## What I Took Away From This

The real learning happened when things broke and I had to trace the path step by step. Public vs. private subnet behavior comes down to routing, not naming — that one stuck with me. I also came away preferring security group references over broadly opened ports.

Walking through the full access path — my machine → bastion → private instance — made the later Terraform rebuild a lot smoother, since I already knew what each resource was supposed to be doing.

## Status

Phase 1 is done. I terminated the manual environment to control costs, and the project has since moved into the Terraform rebuild, recreating the same core architecture as code.
