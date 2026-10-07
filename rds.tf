resource "aws_db_subnet_group" "intro_db_subnet_group" {
  name       = "prod_db_subnet_group"
  subnet_ids = values(aws_subnet.database_subnets)[*].id

}

resource "aws_security_group" "ec2_rds" {
  vpc_id = aws_vpc.prod_vpc.id
  name   = "prod_ec2_rds"
  #   egress {
  #     from_port = 3306
  #     to_port = 3306
  #     protocol = "tcp"
  #     security_groups = [ aws_security_group.rds_ec2.id]
  #   }
  tags = {
    Name = "prod_ec2_rds"
  }

}

resource "aws_security_group" "rds_ec2" {
  vpc_id = aws_vpc.prod_vpc.id
  name   = "prod_rds_ec2"
  tags = {
    Name = "prod_rds_ec2"
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_rds.id]
  }

}

resource "aws_security_group" "rds_sg" {

  vpc_id = aws_vpc.prod_vpc.id

  name = "rds_sg"
  # ingress {
  #     from_port = 3306
  #     to_port = 3306
  #     cidr_blocks = [aws_vpc.prod_vpc.cidr_block]
  #     protocol = "tcp"

  # }
  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
  }

}

resource "aws_db_instance" "intro_db" {
  allocated_storage = 20
  storage_type      = "gp3"
  engine            = "mysql"
  engine_version    = "8.4.9"
  instance_class    = "db.t3.micro"
  identifier        = "flask"
  username          = "admin"
  password          = "Deadman$2001"

  vpc_security_group_ids = [aws_security_group.rds_sg.id, aws_security_group.rds_ec2.id]
  db_subnet_group_name   = aws_db_subnet_group.intro_db_subnet_group.name
  skip_final_snapshot    = true
  # deletion_protection = true

  tags = {
    Name = "Intro_database"
  }


}
