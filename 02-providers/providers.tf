terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.57.0"
    }
  }

  backend "s3" {
    bucket = "tf-backend-s33"
    key = "04-providers/state.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
    region = "eu-north-1"
}

provider "aws" {
    region = "eu-west-1"
    alias = "eu-west"
}

resource "aws_s3_bucket" "eu-north-1" {
    bucket = "tf-bucket-north-1-4455hbdsd"
}

resource "aws_s3_bucket" "eu-west-1" {
  bucket = "tf-bucket-west-1-4545rbdsd"
  provider = aws.eu-west
}