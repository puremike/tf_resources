variable "ec2_instance_type" {
    type = string
    validation {
      condition = var.ec2_instance_type == "t3.micro" || var.ec2_instance_type == "t2.micro"
      error_message = "Only t3.micro or t2.micro ec2 instances are allowed"
    }
}