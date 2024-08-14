provider "aws" {
  region  = var.location_vpc
  profile = "aws-devops-user"

}

resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc1_cidr
  tags = {
    Env   = var.env
    Dept  = "Infra"
    Owner = "Safi"
  }

}
resource "aws_security_group" "sg" {
  for_each = var.security_groups

  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = aws_vpc.vpc1.id

  dynamic "ingress" {
    for_each = each.value["ingress"]
    content {
      from_port   = ingress.value[0]
      to_port     = ingress.value[1]
      protocol    = ingress.value[2]
      cidr_blocks = ingress.value[3]
    }
  }

  # dynamic "ingress" {
  #   for_each = each.value["ingress"]
  #   content {
  #     from_port   = ingress.value["from_port"]
  #     to_port     = ingress.value["to_port"]
  #     protocol    = ingress.value["protocol"]
  #     cidr_blocks = ingress.value["cidr_blocks"]
  #   }
  # }

  dynamic "egress" {
    for_each = each.value["egress"]
    content {
      from_port   = egress.value[0]
      to_port     = egress.value[1]
      protocol    = egress.value[2]
      cidr_blocks = egress.value[3]
    }
  }

  tags = {
    Name = each.value["name"]
  }
}

output "security_group_ids" {
  value = { for sg_key, sg in aws_security_group.sg : sg_key => sg.id }
}














######################################
/*
resource "aws_security_group" "webapp_sg" {
  for_each    = var.webapp_sg_var
  name        = "webap_sg"
  description = "WebApp security group"
  vpc_id      = aws_vpc.vpc1.id

  # Inbound rules
  ingress {
    description = each.value[0]
    from_port   = each.value[1]
    to_port     = each.value[2]
    protocol    = each.value[3]
    cidr_blocks = [each.value[4]]
  }

  ingress {
    description = each.value[5]
    from_port   = each.value[6]
    to_port     = each.value[7]
    protocol    = each.value[8]
    cidr_blocks = [each.value[9]]
  }

  # Outbound rules
  egress {
    description = each.value[10]
    from_port   = each.value[11]
    to_port     = each.value[12]
    protocol    = each.value[13]
    cidr_blocks = [each.value[14]]
  }
}*/
################################################

/*
variable "security_groups" {
  type = map(any)
  default = {
    sg1 = {
      name        = "sg1"
      description = "Security Group 1"
      #vpc_id      = "vpc-12345678"
      ingress = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
    sg2 = {
      name        = "sg2"
      description = "Security Group 2"
      vpc_id      = "vpc-87654321"
      ingress = [
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
*/



#################################################
/*
# To create two vpc using for_each function and map variable data type
resource "aws_vpc" "vpc" {
  for_each   = var.vpc_map_cidrs
  cidr_block = each.value
  tags = {
    Env   = var.env
    Dept  = "Infra"
    Owner = "Safi"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc["cidr1"].id
  cidr_block = "10.10.0.0/24"
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc["cidr2"].id
  cidr_block = "10.20.0.0/24"
}
*/

#################################################
/*
# To create two vpc and associate two subnets for each vpc using local variables and for_each loop function
provider "aws" {
  region  = var.region
  profile = "aws-devops-user"
}

# Define VPCs and Subnets using for_each
locals {
  vpcs = {
    vpc1 = {
      cidr_block = "10.0.0.0/16"
      subnets = {
        subnet1 = "10.0.1.0/24"
        subnet2 = "10.0.2.0/24"
      }
    }
    vpc2 = {
      cidr_block = "10.1.0.0/16"
      subnets = {
        subnet1 = "10.1.1.0/24"
        subnet2 = "10.1.2.0/24"
      }
    }
  }
}

# Create VPCs
resource "aws_vpc" "this" {
  for_each = local.vpcs

  cidr_block = each.value.cidr_block

  tags = {
    Name = each.key
  }
}

# Create Subnets for each VPC
resource "aws_subnet" "this" {
  for_each = { for vpc_key, vpc_value in local.vpcs : vpc_key => vpc_value.subnets }

  vpc_id     = aws_vpc.this[each.key].id
  cidr_block = each.value

  tags = {
    Name = each.key
  }
}

output "vpc_ids" {
  value = aws_vpc.this[*].id
}

output "subnet_ids" {
  value = aws_subnet.this[*].id
}
*/