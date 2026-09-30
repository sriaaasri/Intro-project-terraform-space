resource "aws_security_group" "baston_SG" {

    vpc_id = aws_vpc.prod_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.internet_cidr]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [var.internet_cidr]
    }

    tags = {
      Name = "baston_SG"
    }
  
}

resource "aws_instance" "prod_baston" {

    ami = "ami-0199ac7c9fbf9ed83"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.baston_SG.id , aws_security_group.ec2_rds.id]
    subnet_id = aws_subnet.public_subnets["baston"].id

    root_block_device {
      volume_size = 8
      volume_type = "gp3"
      encrypted = true
    }

    tags = {
      Name = "prod_baston_server"
    }
  
}

# resource "aws_ec2_instance_state" "prod_baston" {
#     instance_id = aws_instance.prod_baston.id
#   state = "running"
# }

