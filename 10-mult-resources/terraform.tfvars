ec2_instance_count = 0

ec2_instance_config_list = [
  {
    instance_type = "t3.micro",
    ami           = "ubuntu"
  },
  {
    instance_type = "t3.micro",
    ami           = "nginx"
  }
]

ec2_instance_config_map = {
  "ubuntu1" = {
    instance_type = "t3.micro"
    ami           = "ubuntu"
  }

  "nginx1" = {
    instance_type = "t3.micro"
    ami           = "nginx"
  }
}