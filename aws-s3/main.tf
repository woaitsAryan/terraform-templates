terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

locals {
  caller_arn = data.aws_caller_identity.current.arn
}

variable "region" {
  description = "AWS Region (e.g. ap-south-1)"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Provisioned_by = "Terraform"
  }
}