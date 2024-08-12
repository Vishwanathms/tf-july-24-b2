## SHow case of Maps , maps of list

maps example 

```
cidr_block = var.cidr-maps[var.location]

vars.tf -- add the below 

variable "cidr-maps" {
  type = map 
  default = {
    "us-east-1" = "10.10.0.0/16",
    "us-west-1" = "10.20.0.0/16"
  }
  
}

terraform .tfvars

add the below 

cidr-maps = {
    "us-east-1" = "10.10.0.0/16",
    "us-west-1" = "10.20.0.0/16"
  }
```

## For_each with maps

```
main.tf 

  for_each = var.cidr-maps1
  provider = aws.dev
  cidr_block = each.value
```
```
vars.tf
variable "cidr-maps1" {
  type = map 
}
```
```
terraform.tfvars
cidr-maps1 = {
    "cidr1" = "10.10.0.0/16",
    "cidr2" = "10.20.0.0/16"
}
```

## For_each with maps(list)string)

```
main.tf
resource "aws_vpc" "main_dev" {
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
}
```

## vars.tf
```
variable "cidr-maps-list" {
  type = map(list(string))
}
```

## terraform.tfvars
```
cidr-maps-list = {
    "cidr1" = ["10.10.0.0/16", "vpc1" , "hr", "vishwa"]
    "cidr2" = ["10.20.0.0/16", "vpc2" , "finance", "vishwa"]
}
```
