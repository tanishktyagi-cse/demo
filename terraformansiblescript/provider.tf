terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
	region = "ap-south-1"
	profile = "default"
}
