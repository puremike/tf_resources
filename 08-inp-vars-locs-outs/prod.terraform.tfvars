ec2_instance_type = "t3.micro"

ec2_instance_config = {
  size = 60
  type = "gp2"
}

additional_tags = {
  "ValuesFrom" = "prod.terraform.tfvars"
}


# PLAN or APPLY
# terraform plan -var-file="prod.terraform.tfvars"