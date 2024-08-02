module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    name = "My_Module_VPC"
    cidr = "10.0.0.0/16"
  }

  # public subnets are indicated by setting the "public" option to true

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-north-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      public     = true
      az         = "eu-north-1b"
    }
    subnet_3 = {
      cidr_block = "10.0.2.0/24"
      public     = true
      az         = "eu-north-1c"
    }
    subnet_4 = {
      cidr_block = "10.0.3.0/24"
      az         = "eu-north-1a"
    }
  }
}