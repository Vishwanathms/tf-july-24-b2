provider "aws" {
  #alias = "dev"
  region = "us-east-1"
  profile = "aws-b1-d1"
}

module "dev_vpc" {
    source = "../modules/vpc"
    #source = "terraform-aws-modules/vpc/aws"
    #source =="git url"
    env = "dev"
    cidr = "192.168.0.0/16"
    tag_name = "vpc_dev1" 
}

module "dev_Subnets" {
  source = "../modules/subnets"
  vcpid = module.dev_vpc.vpcid
  subnet_cidr = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  sub_names = ["sub1", "sub2", "sub3", "sub4"]
  env = "dev"

}

output "subnet_id" {
    value = module.dev_Subnets.subnet_ids
  
}