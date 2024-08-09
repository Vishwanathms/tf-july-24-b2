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

variable "tag_name" {
  
}