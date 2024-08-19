terraform {
  cloud {
    organization = "Scophee"

    workspaces {
      name = "terraform-cli"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.57.0"
    }
  }

}

provider "aws" {
  region = "eu-north-1"
}