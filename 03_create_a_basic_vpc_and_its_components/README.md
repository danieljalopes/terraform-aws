# Create a Basic VPC and Associated Components

## Description
AWS networking consists of multiple components, and understanding the relationship between the networking components is a key part of understanding the overall functionality and capabilities of AWS. It will be created a VPC with an internet gateway, as well as create subnets across multiple Availability Zones.

## Diagram
![diagram](./documentation/diagram.jpg "diagram")

## Actions
* Create a VPC
* Create a Public and Private Subnet in Different Availability Zones
* Create Two Network Access Control Lists (NACLs), and Associate Each with the Proper Subnet
* Create an Internet Gateway, and Connect tt to the VPC
* Create Two Route Tables, and Associate Them with the Correct Subnet

## Components Description
Amazon VPC is the networking layer for Amazon EC2.

The following are the key concepts for VPCs:
* Virtual private cloud (VPC) — A virtual network dedicated to your AWS account.
* Subnet — A range of IP addresses in your VPC.
* Route table — A set of rules, called routes, that are used to determine where network traffic is directed.
* Internet gateway — A gateway that you attach to your VPC to enable communication between resources in your VPC and the internet.
* CIDR block — Classless Inter-Domain Routing. An internet protocol address allocation and route aggregation methodology. For more information, see Classless Inter-Domain Routing
* NACL - A network access control list (ACL) is an optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets. You might set up network ACLs with rules similar to your security groups in order to add an additional layer of security to your VPC. For more information about the differences between security groups and network ACLs

## References
[What is Amazon VPC?](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

[Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)