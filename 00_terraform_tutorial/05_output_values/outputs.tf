output "vpc"{
  value = aws_vpc.main
  #will not echo on the cli
  sensitive = true
}

#instance 
output "instance_ip"{
  value = aws_network_interface.nic.private_ip
}

output "foobar" {
  value = "Tuts"
}