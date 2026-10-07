output "DB_subnets" {

  value = values(aws_subnet.database_subnets)[*].id
}
