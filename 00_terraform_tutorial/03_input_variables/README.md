# Variables

Terraform variables are like variables in any other programming language. Input variables allow you to pass in date to your configurations or modules making them more dynamic. Variables can be set in a number of different ways but the most common that I use is setting them in a specific file for variables.

## What is done
 Declaring a variable
- Using a variables.tf file
- Variable types - string, number, bool, list, map, object
- Using variables
- Different ways of setting variables like with files, command line, environment variables, defaults
- Variable precedence

## Project 1 - Variable not defined
Example of when a variable is declared with no value assign.
It can be ssen that Terraform will ask for a value on the command line.

## Project 2 - Variable is defined
The variable value is assigned by creating the "terraform.tfvars" file
Terraform always include the file "terraform.tfvars".

Is created a file "variables.tf" to declare de used variables.
### Ways to pass variables
- by creating a file with ".auto.tfvars", like "foo.auto.tfvars". This file will be automaticaly loadad by Terraform;
- including a file in the cli: `terraform apply -var-file dev.tfvars`
- assginig the variable in the cli: `terraform apply -var="my_instance_type=t2.large`
- by global variable. Any variable in the machine that starts with "TF_VAR_": `TF_VAR_my_instance_type="t2.large terraform apply"`