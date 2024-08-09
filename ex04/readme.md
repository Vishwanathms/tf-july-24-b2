## want to have one subnet function to create all the subnets in the VPC
## DO NOT USE SEPERATE subnet module/function


Previous the below 
variable "sub1" {}
variable "sub2" {}
variable "sub3" {}

input 
sub1 = "192.168.0.0/24"
sub2 = "192.168.1.0/24"
sub3 = "192.168.2.0/24"
sub4 = "192.168.3.0/24"

functions

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.main_dev.id
  cidr_block = var.sub1
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.main_dev.id
  cidr_block = var.sub2
}

resource "aws_subnet" "sub3" {
  vpc_id = aws_vpc.main_dev.id
  cidr_block = var.sub3
}


Solution

* use list to define the variables of the subnets CIDR
* use list to define the names of the subnets
* use count to get the length og the vairable, to execute the subnet function multiple times.

```
resource "aws_subnet" "Subnets" {
  count = "4"
  vpc_id = aws_vpc.main_dev.id
  cidr_block = var.subnet_cidr[count.index]
  tags = {
    Name = var.sub_names[count.index]
    env = var.env
  }
}
```

