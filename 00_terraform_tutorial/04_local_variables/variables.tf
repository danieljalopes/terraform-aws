# A simple variable
variable "my_instance_type"{
  type        = string
  description = "My instance type"
}

#Object
variable "instance_tags"{
  type = object({
    Name = string
    foo  = number
  })
  description = "Instance tag"

}

