terraform {
  cloud {

    organization = "Scophee"

    workspaces {
      name = "terraform-oidc-cli"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.57.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}