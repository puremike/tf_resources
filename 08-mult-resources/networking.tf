locals {
  project = "Multiple-resources"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = local.project
  project = local.project }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  count      = var.subnet_count
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    project = local.project
    Name    = "local.project-${count.index}"
  }
}