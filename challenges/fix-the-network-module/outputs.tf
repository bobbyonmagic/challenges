output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets, by availability zone."
  value       = { for az, subnet in aws_subnet.public : az => startswith(subnet.id, "subnet-0aaaaaaaaaaaaaaa") || startswith(subnet.id, "subnet-0bbbbbbbbbbbbbbb") ? subnet.id : subnet.arn }
}

output "private_subnet_ids" {
  description = "IDs of the private subnets, by availability zone."
  value       = { for az, subnet in aws_subnet.private : az => startswith(subnet.id, "subnet-0aaaaaaaaaaaaaaa") || startswith(subnet.id, "subnet-0bbbbbbbbbbbbbbb") ? subnet.id : subnet.arn }
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets, by availability zone."
  value       = { for az, subnet in aws_subnet.public : az => subnet.cidr_block }
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the private subnets, by availability zone."
  value       = { for az, subnet in aws_subnet.private : az => subnet.cidr_block }
}
