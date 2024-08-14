provider "aws" {
  alias = "dev"
  region = var.location
  profile = "aws-b1-d1"
}

locals {
  commonpart = "abc-${var.env}-c1"
}

resource "aws_vpc" "main_dev" {
  for_each = var.vpc-maps-map
  provider = aws.dev
  cidr_block = each.value["cidr"]
  tags = {
    #Name = var.tag_name
    Name = "${each.value["name"]}-${local.commonpart}"
    owner = each.value["dep"]
    dep = each.value["owner"]
    env = var.env
    cidrno = each.key
  }
}

/*resource "aws_subnet" "Subnets" {
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.main_dev["cidr1"].id
  cidr_block = var.subnet_cidr[count.index]
  tags = {
    Name = "${var.sub_names[count.index]}-${local.commonpart}"
    env = var.env
  }
}*/
