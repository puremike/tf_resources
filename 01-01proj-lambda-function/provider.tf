terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.57.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~>2.5.0"
    }
  }

}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      ProjectName = "Proj2-Lambda_Function"
    }
  }
} 