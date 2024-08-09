

provider "aws" {
  alias = "dev"
  region = var.location
  profile = "aws-b1-d1"
}

# the below provider is for 2nd accoutn which is prod on aws
provider "aws" {
  alias = "prod" 
  region = var.location
  profile = "aws-b1-d1"
}

provider "azurerm" {
  alias = "dr" 
  features {
    
  }
}

resource "aws_vpc" "main_dev" {
  provider = aws.dev
  cidr_block = var.cidr
  tags = {
    Name = "vpc_dev"
    owner = "vishwa"
    dep = "hr"
    env = var.env
  }

}


resource "aws_vpc" "main_prod" {
  provider = aws.prod
  cidr_block = var.cidr
  tags = {
    Name = "vpc_prod_1"
    owner = "vishwa"
    dep = "hr"
    env = var.env
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  provider = aws.dev
  vpc_id     = aws_vpc.main_dev.id
  cidr_block = "192.168.16.0/20"
}

resource "azurerm_resource_group" "rg01-1" {
  provider = azurerm.dr
    location = "East us"
    name = "rg01"
}

resource "azurerm_virtual_network" "name" {
  provider = azurerm.dr
  location = "East us"
  resource_group_name = azurerm_resource_group.rg01-1.name
  name = "vnet01"
  address_space = ["10.10.0.0/16", "10.20.0.0/16", "172.18.0.0/16"]
}

