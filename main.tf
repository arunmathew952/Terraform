#terraform block'

terraform {
  #required_version = "value"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  #profile = "default"

}
provider "aws" {
  region = "ap-south-1"
  alias  = "mumbai"
}

resource "aws_instance" "demo" {
  ami           = "ami-03978d951b279ec0b"
  instance_type = "t3.small"
  tags = {
    Name = "arun server"
  }
}

resource "aws_s3_bucket" "bkt1" {

  bucket   = "arun-bucket9523"
  provider = aws.mumbai
  tags = {
    Name = "arun-bucket"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  provider   = aws.mumbai
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "ap-south-1a"
  provider = aws.mumbai
  tags = {
    Name = "subnet-01"
  }
}
