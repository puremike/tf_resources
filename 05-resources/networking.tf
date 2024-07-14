# Create a Locals

locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project = "05-resources"
    CostCenter = 1234
  }
}

# Create VPC, Public Subnet, and Internet Gateway

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = merge(local.common_tags, {
        Name = "05-resources"
    })  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    tags = merge(local.common_tags, {
        Name = "05-resources-Pb"
    })
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = merge(local.common_tags, {
        Name = "05-resource-IGW"
    })
}


#Create a Public RTB and Associate with the IGW

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = merge(local.common_tags, {
        Name = "05-resource-Pb-RTB"
    })
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}