# ec2_instance_type = "t2.micro"

# ec2_instance_config = {
#   size = 10
#   type = "io2"
# }

# additional_tags = {
#   ValuesFrom = "prod.auto.tfvars"
# }

# The *.auto.tfvars files are automatically loaded by Terraform when it runs. The values in the *.auto.tfvars files override the values in the terraform.tfvars file. This means that if you have the same variable defined in both the terraform.tfvars file and an *.auto.tfvars file, the value from the *.auto.tfvars file will be used.