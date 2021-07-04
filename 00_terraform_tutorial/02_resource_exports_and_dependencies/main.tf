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
  access_key = "XXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

resource "aws_vpc" "main"{
  cidr_block = "10.5.0.0/16"
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
  instance_type = "t2.micro"

  network_interface {
    #reference to network interface
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

  tags = {
    Name = "ubuntu"
  }
}