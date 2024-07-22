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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_instance_config.size
    volume_type           = var.ec2_instance_config.type
  }

  tags = merge(local.common_tags, var.additional_tags, {
    Name = "web"
  })
}


resource "random_id" "project_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "${local.common_tags.project}-${random_id.project_bucket_suffix.hex}"

  tags = merge(local.common_tags, var.additional_tags)
}

