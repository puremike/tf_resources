terraform {
  # required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}