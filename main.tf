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

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "ap-south-1a"
  provider = aws.mumbai
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.128.0/17"
  availability_zone = "ap-south-1b"
  provider = aws.mumbai
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id   = aws_vpc.main.id
  provider = aws.mumbai
  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table" "private-route-table" {
  vpc_id   = aws_vpc.main.id
  provider = aws.mumbai
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
  provider       = aws.mumbai
}

resource "aws_route_table_association" "private-subnet-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
  provider       = aws.mumbai
}

resource "aws_internet_gateway" "igw12" {
  vpc_id = aws_vpc.main.id
  provider = aws.mumbai
  tags = {
    Name = "igw"
  }

}
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw12.id
  provider               = aws.mumbai
}
