variable "subnet_cidr" {
    type = list
    default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  
}

/*variable "sub_names" {
  type = list 
}*/

variable "location" {
    type = string
    validation {
      condition = contains(["us-east-1", "us-west-1"], var.location)
      error_message = "Location must be east-1 or west-1"
    }
    default = "us-east-1"
}
variable "cidr" {
}
variable "env" {
    type = string
    validation {
      condition = contains(["dev", "test", "prod"], var.env)
      error_message = "Env must be one of dev test prod"
    }
}

variable "tag_name" {}


/*variable "cidr-maps" {
  type = map 
}

variable "cidr-maps1" {
  type = map 
}

variable "cidr-maps-list" {
  type = map(list(string))
}


variable "vpc-maps-map" {
  type = map(map(any))
}*/