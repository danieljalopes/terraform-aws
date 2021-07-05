# Output Values
Output values in Terraform can return data from resources or modules. 

Outputs are helpful to output data from modules that can be used as input to other resources or modules. Outputs can be outputted to the terminal to help with debugging or if needed to what data and values are 

## Useful commands

Apply new infrastructure immediatly
````
terraform apply -auto-approve
````

Show output values
````
terraform output
````

Show output of "instance_ip"
````
terraform instance_ip
````