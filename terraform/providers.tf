terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket  = "thaer-terraform"
    key     = "me/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.default_tags
  }
}
