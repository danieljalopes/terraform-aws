# Create a basic lambda and send logs to Cloudwatch

## Description
In this project it is created a Lambda function that runs code in Javascript that connects to a site and generates logs that are sent to Cloudwatch.


## Diagram
![diagram](./documentation/Diagram.jpg "diagram")

## What is done
* Create a Lambda function
* Create a Javascript file
* Send Logs to Amazon CloudWatch

## How to deploy
Login to your AWS account and get the Credentials.
Then in the same place as the file 'main.tf':

````
# this will initiate Terraform on your project
terraform init

# this will findout what operations Terraform will perform
terraform plan 

# this will apply what is configure in your project
terraform apply 
````


## Credentials Setup
To find your credentials go to the places shown by the pictures:

 ![alt text]( ./documentation/aws_credentials_00.jpg "Account Menu")

 ![alt text]( ./documentation/aws_credentials_01.jpg "Credentials")

Set credentials on file main.tf and update:

```
provider "aws" {
  region     = "us-west-1"
  access_key = "xxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
````


## Check Results
1. Open the lambda URLChecker
2. Create test event
![diagram](./documentation/lambda_create_test_event.jpg "")
3. Run test event
![diagram](./documentation/run_test_event.jpg "")
4. Check test event results
![diagram](./documentation/lambda_test_results.jpg "")
5. go to clouwdwatch and view the logs
![diagram](./documentation/lambda_cloudwatch_logs.jpg "")
