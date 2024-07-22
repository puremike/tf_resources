variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}


variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  default = []

  # validation to check the instance_type
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro", "t3.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro and t3.micro instances are supported."
  }

  # validation {
  #   condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_config_list[instance_type])
  #   error_message = "Only t2.micro and t3.micro instances are supported."
  # }

  # validation to check the amis
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only ubuntu and nginx amis are supported"
  }
}


variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
  }))

# Validation to check for instance type
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t2.micro", "t3.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro or t3.micro instances are supported"
  }

  # Validation to check the amis

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only nginx or ubuntu amis are supported."
  }
}