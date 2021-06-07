terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
# This credentials are not valid
provider "aws" {
  region = "us-east-1"
  access_key = "xxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}


#Create S3 bucket
resource "aws_s3_bucket" "myawsbucket-123456" {
  bucket = "myawsbucket-123456"
  acl    = "public-read" #bucket public access
 // policy = file("policy.json")

  #enable static website hosting
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

#Put the index.html on the bucket
resource "aws_s3_bucket_object" "index_file" {
  bucket = "myawsbucket-123456"
  key    = "index.html"
  source = "index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("index.html")
}


#Put the error.html on the bucket
resource "aws_s3_bucket_object" "error_file" {
  bucket = "myawsbucket-123456"
  key    = "error.html"
  source = "error.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("error.html")
}

#bucket policy
resource "aws_s3_bucket_policy" "myawsbucket-123456-policy" {
  bucket = aws_s3_bucket.myawsbucket-123456.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "MYBUCKET-123456-POLICY",
    "Statement":[{
       "Sid":"PublicReadGetObject",
       "Effect":"Allow",
       "Principal": "*",
       "Action":["s3:GetObject"],
       "Resource":["${aws_s3_bucket.myawsbucket-123456.arn}/*"],
    }]
  })
}

