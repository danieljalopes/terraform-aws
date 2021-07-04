## Resource Exports and Dependencies

Each resource in Terraform exports data and information about the resource. This data can then be used as input into other resources. When data from one resource is used for another then it becomes a dependency. Thankfully Terraform automatically figures out any dependencies allowing users not to have to worry about it much.

## What is done
- Create an AWS VPC, Subnet and Instance
- Use the exported attributes from one resource into another creating a dependency