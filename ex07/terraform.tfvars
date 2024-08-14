# Environment Varaibles
env = "dev"

#Location variables
location_vpc = "us-east-1"


/*
#CIDR Variables

vpc_map_cidrs = {
  "cidr1" = "10.10.0.0/16"
  "cidr2" = "10.20.0.0/16"
}

vpc_cidr_map_list = {
  "cidr1" = ["10.10.0.0/16", "vpc1", "Dev", "Safi"]
  "cidr2" = ["10.20.0.0/16", "vpc2", "Test", "Safi"]
}

vpc_cidr_map_map = {
  vpc1 = {
    cidr  = "10.10.0.0/16"
    Dept  = "Fin"
    Env   = "Dev"
    Owner = "Safi"
  }
  vpc2 = {
    cidr  = "10.20.0.0/16"
    Dept  = "Fin"
    Env   = "Test"
    Owner = "Safi"
  }

}

# webapp_sg_var = {
#   "webapp_sg1" = ["Allow SSH", "22", "22", "tcp", "0.0.0.0/0", "Allow HTTP", "80", "80", "tcp", "0.0.0.0/0","Allow all outbound traffic", "0", "0", "-1", "0.0.0.0/0" ]
#   "webapp_sg2" = ["Allow SSH", "22", "22", "tcp", "0.0.0.0/0", "Allow HTTP", "80", "80", "tcp", "0.0.0.0/0","Allow all outbound traffic", "0", "0", "-1", "0.0.0.0/0" ]

# }
*/

vpc1_cidr = "10.0.0.0/16"

security_groups = {
  sg1 = {
    name        = "sg1"
    description = "Security Group 1"
    #vpc_id      = "vpc-12345678"
    ingress = [
      ["22", "22", "tcp", ["0.0.0.0/0"]],
      ["80", "80", "tcp", ["0.0.0.0/0"]]
    ]
    egress = [
      ["0", "0", "-1", ["0.0.0.0/0"]]
    ]
  }
  sg2 = {
    name        = "sg2"
    description = "Security Group 2"
    #vpc_id      = "vpc-87654321"
    ingress = [
      ["443", "443", "tcp", ["0.0.0.0/0"]]
    ]
    egress = [
      ["0", "0", "-1", ["0.0.0.0/0"]]
    ]
  }
}

