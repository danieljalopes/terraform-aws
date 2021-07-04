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
  access_key = "AKIA2JXBGFQDOS4SYNV2"
  secret_key = "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"
}


#resource for an ec2 instance for a ubuntu machine
resource "aws_instance" "ubuntu" {
  ami           = "ami-9aeed5f2"
  instance_type = var.my_instance_type

  #it will be passed an object
  tags = var.instance_tags
}