
locals {
  commonpart = "abc-${var.env}-c1"
}

resource "aws_vpc" "main_dev" {
  cidr_block = var.cidr
  tags = {
    Name = var.tag_name
    owner = "vishwa"
    dep = "hr"
    env = var.env
  }
  
}
