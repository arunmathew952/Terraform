terraform {
#   backend "s3" {
#     bucket = "tf-state-bucket-arunmathew952"
#     key = "dev/ec2/terraform.tfstate"
#     region = "us-west-1"
#     encrypt = true
    
#   }
}
provider "aws" {
  region = "us-west-1"
  #profile = "default"

}
resource "aws_s3_bucket" "s3_bucket_1" {
    bucket = "tf-state-bucket-arunmathew952"
  
}
resource "aws_instance" "demo" {
  ami           = "ami-03978d951b279ec0b"
  instance_type = "t3.small"
  tags = {
    Name = "arun server"
  }
}