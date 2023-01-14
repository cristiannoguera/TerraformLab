terraform {
#   required_version = ">= 1.3.7"
   required_providers {
    aws = {
      version = ">= 4.49.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
    profile = var.profileaws
    region = var.region
    default_tags {
        tags = local.tags
    } 
}