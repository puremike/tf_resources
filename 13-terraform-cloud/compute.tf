resource "random_id" "this" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket = "terraform-cli-${random_id.this.hex}"

  tags = {
    CreatedBy = "Terraform Cloud"
  }
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
  instance_type = var.ec2_instance_type

  tags = {
    Name    = "ec2_web"
    Project = "Terraform Cloud"
  }
}

output "random_id" {
  value = random_id.this.hex
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}