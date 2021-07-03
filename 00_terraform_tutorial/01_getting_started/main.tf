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
  access_key = "AKIAU4CZYEPPRQODS56W"
  secret_key = "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"
}


#resource for an ec2 instance for a ubuntu machine
resource "aws_instance" "ubuntu" {
  ami           = "ami-006ca59a1e09f117b"
  instance_type = "t2.micro"

  tags = {
    Name = "ubuntu"
  }
}