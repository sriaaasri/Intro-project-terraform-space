resource "aws_vpc" "prod_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "Prod-VPC"
        
    }
}

resource "aws_subnet" "database_subnets" {
    for_each = var.database_subnets
    cidr_block = each.value.cidr
    vpc_id = aws_vpc.prod_vpc.id
    availability_zone = each.value.az
    map_public_ip_on_launch = false

    tags = {
        Name = "${aws_vpc.prod_vpc.tags.Name}-${each.key}"
        Vpc = aws_vpc.prod_vpc.tags.Name
        source =  "console"
    }
}

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
    for_each = var.database_subnets
    subnet_id = aws_subnet.database_subnets[each.key].id
    route_table_id = aws_route_table.database-route-table["database"].id
  
}


####### Public subnet

resource "aws_subnet" "public_subnets" {

    for_each = var.public_subnets
    vpc_id = aws_vpc.prod_vpc.id
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    map_public_ip_on_launch = true

    tags = {
      Name = each.key
      vpc = aws_vpc.prod_vpc.tags.Name
    }
  
}

resource "aws_internet_gateway" "prod_IG" {
    vpc_id = aws_vpc.prod_vpc.id
    tags = {
      Name = "prod_vpc_IG"
    }
  
}

resource "aws_route_table" "public_routetable" {
    vpc_id = aws_vpc.prod_vpc.id
    for_each = var.public_routetable
    tags = {
      Name = each.value.name
    }
}

resource "aws_route" "subnet_IG_route" {
  route_table_id = aws_route_table.public_routetable["public_RT"].id
  #Destination in console
  destination_cidr_block = "0.0.0.0/0"

  #Target in console
  gateway_id = aws_internet_gateway.prod_IG.id

}

resource "aws_route_table_association" "public_subnets_association" {
    for_each = var.public_subnets
    subnet_id = aws_subnet.public_subnets[each.key].id
    route_table_id = aws_route_table.public_routetable["public_RT"].id
}
