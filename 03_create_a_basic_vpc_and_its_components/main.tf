terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.44.0"
    }
  }
}


# Configure the AWS Provider
# This credentials are not valid
provider "aws" {
  region = "us-east-1"
  access_key = "AKIA5NG2LB4XIM7K7ZU3"
  secret_key = "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"
}


# VPC
resource "aws_vpc" "VPC1" {
  cidr_block = "172.16.0.0/16"
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC1.id

}

#Public subnet
resource "aws_subnet" "Public1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block =  "172.16.1.0/24"
  availability_zone = "us-east-1a"
  
}

#Private subnet
resource "aws_subnet" "Private1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block =  "172.16.2.0/24"
   availability_zone = "us-east-1b"
}


#------- Public NACL -------
#Network Access List (NACL)
resource "aws_network_acl" "Public_NACL" {
  vpc_id = aws_vpc.VPC1.id
  subnet_ids = [aws_subnet.Public1.id]
}

#NACL inbound HTTP port 80
resource "aws_network_acl_rule" "Public_http_inbound" {
  network_acl_id = aws_network_acl.Public_NACL.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
  from_port      = 80
  to_port        = 80
}

#NACL inbound SSH port 22
resource "aws_network_acl_rule" "Public_ssh_inbound" {
  network_acl_id = aws_network_acl.Public_NACL.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
  from_port      = 22
  to_port        = 22
}


#NACL outbound
#This rule is to allow for the receiver to respond to emiter
#The receiver will use any port on the range 1024-65535
resource "aws_network_acl_rule" "Public_outbound" {
  network_acl_id = aws_network_acl.Public_NACL.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
  from_port      = 1024
  to_port        = 65535
}

#------- Public NACL -------

#------- Private NACL -------
#Network Access List (NACL)
resource "aws_network_acl" "Private_NACL" {
  vpc_id = aws_vpc.VPC1.id
  subnet_ids = [aws_subnet.Private1.id]
}

#------- Private NACL -------

/*
resource "aws_route_table" "router" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.example.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  }

  tags = {
    Name = "example"
  }
}
*/
