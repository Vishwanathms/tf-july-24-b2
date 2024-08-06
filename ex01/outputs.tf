output "vpc-id" {
  value = aws_vpc.vpc_c1.id
}
output "rt-id" {
  value = aws_vpc.vpc_c1.main_route_table_id
}