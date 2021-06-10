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
  access_key = "XXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXsource"
}


#lambda function called URLChecker
resource "aws_lambda_function" "url_checker" {
  filename      = "index.zip"
  function_name = "URLChecker"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"


  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime = "nodejs12.x"

  /*
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.example,
  ]
  */
}

#zips de index.js file to index.zip
data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "index.js"
    output_path   = "index.zip"
}

#IAM Execution Role for the lambda 
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"


  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.url_checker.function_name}"
  retention_in_days = 14
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"

  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}