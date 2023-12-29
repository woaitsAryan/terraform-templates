terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

variable "region" {
  description = "AWS Region (e.g. ap-south-1)"
  type        = string
}

variable "db_name" {
  description = "Name of DynamoDB"
  type = string
}

variable "dax_name"{
  description = "Name of DAX cluster"
  type = string
}

provider "aws" {
  region = var.region
}

resource "aws_dynamodb_table" "table" {
  name           = var.db_name
  read_capacity  = 20
  write_capacity = 20
  billing_mode = "PROVISIONED"
  hash_key       = "ID"
  range_key = "CreatedAt"
  

  attribute {
    name = "ID"
    type = "S"
  }
  attribute {
    name = "CreatedAt"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

}