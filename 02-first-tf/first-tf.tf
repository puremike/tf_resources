terraform {
  required_providers {
    random = {
        source = "hashicorp/random"
        version = "~>3.6.0"
    }
    aws = {
        source = "hashicorp/aws"
        version = "~>5.57.0"
    }
    
  }
}

provider "aws" {
    region = "eu-north-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "tf_bucket_name" {
    bucket =  "tf-bucket-name-${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
    value = aws_s3_bucket.tf_bucket_name.bucket
}