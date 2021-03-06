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
  access_key = "XXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
}


#resource for an ec2 instance for a ubuntu machine
resource "aws_instance" "ubuntu" {
  ami           = "ami-9aeed5f2"
  instance_type = var.my_instance_type

  #it will be passed an object
  tags = var.instance_tags
}