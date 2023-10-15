terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucketname" {
  type    = string
  default = "sagi-demo-bucket"
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  number  = true
}

module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.0"

  count = 10

  bucket = "${var.bucketname}-${count.index}-${random_string.random.id}"
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  count  = 10
  bucket = module.s3[count.index].s3_bucket_id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "bucket-acl-ownership" {
  count  = 10
  bucket = module.s3[count.index].s3_bucket_id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

output "s3_bucket_arn" {
  value = module.s3[*].s3_bucket_arn
}
