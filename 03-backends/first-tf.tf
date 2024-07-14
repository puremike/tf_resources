terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.57.0"
    }

    random = {
        source = "hashicorp/random"
        version = "~>3.6.0"
    }
  }

  backend "s3" {
    bucket = "tf-backend-s33"
    key = "03-backends/state.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6 
}

resource "aws_s3_bucket" "tf_bucket_name" {
  bucket = "tf-bucket-name-${random_id.bucket_suffix.hex}"  
}

output "bucket" {
  value = aws_s3_bucket.tf_bucket_name.bucket
}