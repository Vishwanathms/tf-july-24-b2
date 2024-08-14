output "subnet_ids" {
  value = aws_subnet.Subnets[*].id
}