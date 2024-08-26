
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
    #vpc_id      = "vpc-12345678"
    ingress = [
      ["443", "443", "tcp", ["0.0.0.0/0"]],
      ["8080", "8080", "tcp", ["0.0.0.0/0"]]
    ]
    egress = [
      ["0", "0", "-1", ["0.0.0.0/0"]]
    ]
  }
}