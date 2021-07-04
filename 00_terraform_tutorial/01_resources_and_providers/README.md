# Providers and Resources
This a simple project to show how concepts about Terraform's resources and providers

It will be created an AWS EC2 instance, running Ubuntu.

## Providers
Are the resources types and data sources that Terraform can manage.
AWS, Azure and Google Cloud Platform are known providers

[Providers](https://registry.terraform.io/browse/providers)
[AWS Providers](https://registry.terraform.io/providers/hashicorp/aws/latest)

## Resources
Resources are the artfacts that Terraform aims to manage.

[Resources](https://www.terraform.io/docs/language/resources/index.html)

## How to run
On the same folder as the main.tf run:
To initiate a project
````
terraform init
````
This will download all the providers and everithing needed to apply resources 

To see what Terraform is going to do, but not apply
````
terraform plan
````

To apply
````
terraform apply
````