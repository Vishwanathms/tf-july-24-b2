location = "us-west-1"
cidr = "192.168.0.0/20"
env = "dev"
tag_name = "vpc_dev"

subnet_cidr = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
sub_names = ["sub1", "sub2", "sub3", "sub4"]

# we want to run for only one of the values 
cidr-maps = {
    "us-east-1" = "10.10.0.0/16",
    "us-west-1" = "10.20.0.0/16"
}

# we want to run for all the values together
cidr-maps1 = {
    "cidr1" = "10.10.0.0/16",
    "cidr2" = "10.20.0.0/16"
}


cidr-maps-list = {
    "cidr1" = ["10.10.0.0/16", "vpc1" , "hr", "vishwa"]
    "cidr2" = ["10.20.0.0/16", "vpc2" , "finance", "vishwa"]
}

vpc-maps-map = {
    "cidr1" = {
        cidr = "10.10.0.0/16" 
        name = "vpc1"  
        dep = "hr" 
        owner = "vishwa"
    }
    "cidr2" = {
        cidr = "10.20.0.0/16" 
        name = "vpc2"  
        dep = "finance" 
        owner = "vishwa"
    }
}





