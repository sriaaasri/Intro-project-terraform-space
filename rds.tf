resource "aws_db_subnet_group" "intro_db_subnet_group" {
    name = "prod_db_subnet_group"
    subnet_ids = values(aws_subnet.database_subnets)[*].id
  
}

resource "aws_security_group" "rds_sg" {

    vpc_id = aws_vpc.prod_vpc.id
    
    name = "rds_sg"
    ingress {
        from_port = 3306
        to_port = 3306
        cidr_blocks = [aws_vpc.prod_vpc.cidr_block]
        protocol = "tcp"
    }
    egress {
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        protocol = -1
    }
  
}

# resource "aws_db_instance" "intro_db" {
#     allocated_storage = 20
#     storage_type = "gp3"
#     engine = "mysql"
#     engine_version = "8.4.9"
#     instance_class = "db.t3.micro"
#     identifier = "flask"
#     username = "admin"
#     password = "Deadman$2001"

#     vpc_security_group_ids = [aws_security_group.rds_sg.id]
#     db_subnet_group_name = aws_db_subnet_group.intro_db_subnet_group.name
#     skip_final_snapshot = true
  
# }
