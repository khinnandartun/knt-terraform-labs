terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  backend "s3" {
    bucket = "knt-vpc-practise-bkt"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}