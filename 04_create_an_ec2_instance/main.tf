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
  access_key = "XXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

# VPC
resource "aws_vpc" "VPC1" {
  cidr_block = "172.16.0.0/16"
}

#subnet
resource "aws_subnet" "Subnet1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block =  "172.16.1.0/24"
  availability_zone = "us-east-1a"
  
}

#Network interface for the ubuntu_machine
resource "aws_network_interface" "net_interf" {
  subnet_id   = aws_subnet.Subnet1.id
  private_ips = ["172.16.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

#setup ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#creating the VM and deploy it
resource "aws_instance" "ubuntu_machine" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.net_interf.id
    device_index         = 0
  }

  tags = {
    Name = "HelloWorld"
  }
}