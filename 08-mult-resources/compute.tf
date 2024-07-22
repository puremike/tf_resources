locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
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

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# resource "aws_instance" "web" {
#   count         = var.ec2_instance_count
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"
#   # subnet_id     = aws_subnet.main[0].id
#   subnet_id = aws_subnet.main[
#     count.index % length(aws_subnet.main)
#   ].id
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 10
#     volume_type           = "gp3"
#   }

#   tags = {
#     project = local.project
#     Name    = "web-ec2-${count.index}"
#   }
# }    

# resource "aws_instance" "web_from_list" {
#   count         = length(var.ec2_instance_config_list)
#   ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
#   instance_type = var.ec2_instance_config_list[count.index].instance_type
#   subnet_id = aws_subnet.main[
#     count.index % length(aws_subnet.main)
#   ].id

#   tags = {
#     project = local.project
#     Name    = "web-ec2-${count.index}"
#   }
# }    


resource "aws_instance" "web_from_map" {
  for_each      = var.ec2_instance_config_map
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[0].id

  tags = {
    project = local.project
    Name    = "web-ec2-${each.key}"
  }
}    