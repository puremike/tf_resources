locals {
  common_tags = {
    ProjectName = "Public Resources"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  # owners      = ["xxxxxx"]  # Canonical's AWS account ID
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "web"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = local.common_tags
}