provider "aws" {
  alias = "dev"
  region = var.location
  #profile = "aws-b1-d1"
  #profile = "specnet-tf-aug-vms"
}


resource "aws_vpc" "main_dev" {
  provider = aws.dev
  cidr_block = var.cidr
  tags = {
    Name = var.tag_name
    owner = "vish"
    dep = "hr"
    env = var.env
  }
}
