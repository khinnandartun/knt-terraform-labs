resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "custom_vpc"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet_1_cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "public_subnet_1c"
  }
}

resource "aws_subnet" "public_subnet_2b" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet_2_cidr_block
  availability_zone = "ap-southeast-1b"
  # map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_2b"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "private_subnet_b"
  }
}

resource "aws_subnet" "isolated_private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.isolated_private_subnet_cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "isolated_private_subnet"
  }
}

resource "aws_internet_gateway" "custom_vpc_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_vpc_gw"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "custom_vpc_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_2b.id

  tags = {
    Name = "custom_vpc_NAT"
  }

  depends_on = [aws_internet_gateway.custom_vpc_gw]
}