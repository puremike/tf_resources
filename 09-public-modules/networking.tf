locals {
  vpc_cidr     = "10.0.0.0/16"
  pri_sub_cidr = ["10.0.0.0/24"]
  pub_sub_cidr = ["10.0.128.0/24"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "pub-resources-vpc"
  cidr = local.vpc_cidr

  azs                = data.aws_availability_zones.available.names # ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  private_subnets    = local.pri_sub_cidr                          # ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = local.pub_sub_cidr                          # ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    ProjectName = local.common_tags.ProjectName
  }
}
