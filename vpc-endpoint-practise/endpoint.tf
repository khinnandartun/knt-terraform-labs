resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "custom-vpc"
  }

}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_security_group" "sg_custom_vpc" {
  name        = "sg_custom_vpc"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ping  from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_ec2_instance_connect_endpoint" "ec2_endpoint" {
  subnet_id = aws_subnet.private_subnet.id
  tags = {
    Name = "ec2-endpoint"
  }
}

resource "aws_instance" "knt_test" {
  ami                         = "ami-0eeadc4ab092fef70"
  instance_type               = "t2.micro"
  key_name                    = var.instance_key_name
  subnet_id                   = aws_subnet.private_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_custom_vpc.id]
  tags = {
    Name = "knt-test"
  }
}
