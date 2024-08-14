# Variables
variable "env" {
  type = string
}

variable "location_vpc" {
  type = string
}

variable "vpc1_cidr" {
  type = string
}

variable "vpc_map_cidrs" {
  type = map(any)
  default = {
    "cidr1" = "10.10.0.0/16"
    "cidr2" = "10.20.0.0/16"

  }
}

# variable "vpc_cidr_map_list" {
#   type = map(list(any))

# }

# variable "vpc_cidr_map_map" {
#   type = map(map(any))

# }

# variable "webapp_sg_var" {
#   type = map(list(any))

# }

variable "security_groups" {
  type    = map(any)
  default = {}
}