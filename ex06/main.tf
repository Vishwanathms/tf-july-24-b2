provider "aws" {
  alias = "dev"
  region = var.location
  profile = "aws-b1-d1"
}


/*resource "aws_vpc" "main_dev" {
  for_each = var.cidr-maps-list
  provider = aws.dev
  cidr_block = each.value[0]
  tags = {
    #Name = var.tag_name
    Name = each.value[1]
    owner = each.value[3]
    dep = each.value[2]
    env = var.env
    cidrno = each.key
  }
}*/

resource "aws_vpc" "main_dev" {
  for_each = var.vpc-maps-map
  provider = aws.dev
  cidr_block = each.value["cidr"]
  tags = {
    #Name = var.tag_name
    Name = each.value["name"]
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
    Name = var.sub_names[count.index]
    env = var.env
  }
}*/
