output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private1_subnet_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.private1.id
}

output "private2_subnet_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.private2.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.rt.id
}
