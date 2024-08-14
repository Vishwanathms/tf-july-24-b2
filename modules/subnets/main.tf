resource "aws_subnet" "Subnets" {
  count = length(var.subnet_cidr)
  vpc_id = var.vcpid
  cidr_block = var.subnet_cidr[count.index]
  tags = {
    Name = var.sub_names[count.index]
    env = var.env
  }
}