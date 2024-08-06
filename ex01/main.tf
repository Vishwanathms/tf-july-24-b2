provider "aws" {
  region = "us-east-1"
  profile = "aws-b1-d1"
}

resource "aws_vpc" "vpc_c1" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "vpc1"
    owner = "vishwa"
    dep = "hr"
  }
}

