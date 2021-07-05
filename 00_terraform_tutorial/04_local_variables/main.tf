terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #Credentials
  access_key = "XXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

locals {
  setup_name = "tuts"
  foobar = "will"
}


resource "aws_vpc" "main"{
  cidr_block = "10.5.0.0/16"

  tags = {
    #locals variables applyed
    Name  = "${local.setup_name}-vpc"
    foo   = local.setup_name
  }
}

resource "aws_subnet" "web"{
  #reference to vpc main
  vpc_id = aws_vpc.main.id
  cidr_block = "10.5.0.0/16"

  tags={
    Name = "web-subnet"
  }
}

resource "aws_network_interface" "nic" {
  #reference to subnet web
  subnet_id   = aws_subnet.web.id
  private_ips = ["10.5.1.1"]

  tags = {
    Name = "primary_network_interface"
  }
}


#resource for an ec2 instance for a ubuntu machine
resource "aws_instance" "ubuntu" {
  ami           = "ami-9aeed5f2"
  instance_type = var.my_instance_type

  network_interface {
    #reference to network interface
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

 #it will be passed an object
  tags = var.instance_tags
}