locals {
  allowed_instance_type = ["t2.micro", "t3.micro"]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = {
    Name      = "web"
    terraform = "true"
    CostCenter = "1234"
  }

  lifecycle {
    create_before_destroy = true

    postcondition {
      condition     = contains(local.allowed_instance_type, var.instance_type)
      error_message = "Invalid Instance Type"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24" # Adjust this to your desired CIDR block

  lifecycle {
    postcondition {
      condition     = self.availability_zone == "eu-north-1a"
      # condition     = contains(data.aws_availability_zones.names, self.availability_zone) # the resources must be created first. Else, there will be error.
      error_message = "Invalid Availability Zone!"
    }
  }
}


check "cost-center-tag" {
    assert {
      condition = can(aws_instance.this.tags.CostCenter != "")
      error_message = "The instance does not have a Cost Center tag"
    }  
}