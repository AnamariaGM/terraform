# Declaring required provider and version for AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Source of the AWS provider
      version = "5.22.0"         # Version of the AWS provider
    }
  }
}

# Defining AWS provider configuration
provider "aws" {
  region = var.region  # Set the AWS region based on the provided variable
}
