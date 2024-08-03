variable "instance_type" {
  type    = string
  default = "t3.micro"

  # validation {
  #   condition = contains(["t3.micro", "t2.micro"], var.instance_type)
  #   error_message = "Invalid Instance type"
  # }
}