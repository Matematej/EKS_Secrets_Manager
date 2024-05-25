terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
#  profile = "Workloads-profile"
}

module "landing_zone" {
  source = "../landing_zone"
}

module "security" {
  source = "../security"
}