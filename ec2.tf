resource "aws_security_group" "baston_SG" {

  vpc_id = aws_vpc.prod_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.internet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.internet_cidr]
  }

  tags = {
    Name = "baston_SG"
  }

}

data "aws_key_pair" "Jenkins_keyPair_updated" {
  key_name = "Jenkins_keyPair_updated"
}

resource "aws_instance" "prod_baston" {

  ami                    = "ami-0199ac7c9fbf9ed83"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.baston_SG.id, aws_security_group.ec2_rds.id]
  subnet_id              = aws_subnet.public_subnets["public_subnet_2"].id
  key_name               = data.aws_key_pair.Jenkins_keyPair_updated.key_name
  user_data              = file("baston_userData.sh")

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "prod_baston_server"

  }

  lifecycle {
    create_before_destroy = true
  }

}


# resource "aws_ec2_instance_state" "prod_baston" {
#     instance_id = aws_instance.prod_baston.id
#   state = "running"
# }

