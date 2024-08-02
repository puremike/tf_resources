locals {
  common_tags = {
    ProjectName = "My_Module"
    terraform   = true
  }

  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public
  }

  private_subnets = {
    for key, config in var.subnet_config : key => config if !config.public
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr
  tags = merge(local.common_tags, {
    Name = var.vpc_config.name
  })
}

resource "aws_subnet" "this" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr_block

  tags = {
    Name   = each.key
    Access = each.value.public ? "Public" : "Private"
  }

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = <<-EOT
      The AZ "${each.value.az}" provided for the subnet "${each.key}" is invalid.
      
      The applied AWS region "${data.aws_availability_zones.available.id}" supports the following AZs:
      [${join(", ", data.aws_availability_zones.available.names)}]
      EOT
    }
  }
}

resource "aws_internet_gateway" "main" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags, {
    Name = "IGW"
  })
}

#Create a Public RTB and Associate with the IGW

resource "aws_route_table" "public" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
  tags = merge(local.common_tags, {
    Name = "Pb-RTB"
  })
}

resource "aws_route_table_association" "public" {

  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public[0].id
}