resource "aws_vpc" "prod_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "Prod-VPC"
        
    }
}

resource "aws_subnet" "database_subnet" {
    # count = length(var.public_subnets)
    for_each = var.database_subnets
    cidr_block = each.value.cidr
    vpc_id = aws_vpc.prod_vpc.id
    availability_zone = each.value.az
    map_public_ip_on_launch = false

    tags = {
        Name = "${aws_vpc.prod_vpc.tags.Name}-${each.key}"
        Vpc = aws_vpc.prod_vpc.tags.Name
    }
}

# resource "aws_subnet" "database_subnet" {
#     cidr_block = "10.0.1.0/24"
#     vpc_id = aws_vpc.prod_vpc.id
#     availability_zone = "ap-south-2a"
#     map_public_ip_on_launch = false

#     tags = {
#         Name = "${aws_vpc.prod_vpc.tags.Name}-database-subnet-1"
#         Vpc = aws_vpc.prod_vpc.tags.Name
#     }
# }

resource "aws_route_table" "database-route-table" {

    for_each = var.database_route_tables
    
    vpc_id = aws_vpc.prod_vpc.id

    tags = {
      Name = each.value.name
      Vpc = aws_vpc.prod_vpc.tags.Name
    }

}

# resource "aws_route" "prod-vpc-local-route" {

#     for_each = var.route_tables
#     route_table_id = aws_route_table.database-route-table[each.key].id

#     destination_cidr_block = "10.0.0.0/16"
#     tage
  
# }

resource "aws_route_table_association" "database-association" {
    for_each = var.database_route_tables
    subnet_id = aws_subnet.database_subnet[each.key].id
    route_table_id = aws_route_table.database-route-table[each.key].id
  
}

