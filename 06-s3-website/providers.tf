terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.57.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}