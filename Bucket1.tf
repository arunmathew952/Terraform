terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.23.0"
    }
  }
}
provider "aws" {
    region = "ap-south-1"
    
}
resource "aws_s3_bucket" "bucket1" {
    bucket = "arun_bucket952"
    provider = aws
    tags = {
    Name = "arun_bucket"
    }
  
}