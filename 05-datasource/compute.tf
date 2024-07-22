data "aws_ami" "ubuntu" {
most_recent = true
# owners      = ["xxxxxx"]  # Canonical's AWS account ID
owners      = ["amazon"]

filter {
name   = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
}

filter {
name   = "virtualization-type"
values = ["hvm"]
 }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "Prod"
  }
}  

data "aws_availability_zones" "available" {
  state = "available"
} 

data "aws_iam_policy_document" "static-web-s3" {
  statement {
    sid = "PublicReadS3Object"

    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "${aws_s3_bucket.PublicReadS3Object.arn}/*",
    ]
  }

}

resource "aws_s3_bucket" "PublicReadS3Object" {
    bucket = "plublic-read-s3-object-bkt"  
}

resource "aws_instance" "web" {
    # AMI NGINX = "ami-0f9b0c52c0cbf4f99"
    # AMI UBUNTU = "ami-07c8c1b18ca66bb07"
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    associate_public_ip_address = true
}

output "ubuntu_ami" {
    value = data.aws_ami.ubuntu.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
    value = data.aws_region.current 
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "avzs" {
    value = data.aws_availability_zones.available
}

output "S3PublicReadObject" {
  value = data.aws_iam_policy_document.static-web-s3.json
}
  