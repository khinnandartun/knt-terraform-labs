resource "aws_vpc" "custom_vpc" {
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = each.value.vpc_name
  }
  for_each = var.vpc_cidr_list
}

resource "aws_subnet" "custom_subnet" {
  vpc_id            = aws_vpc.custom_vpc[each.value.vpc_name].id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.subnet_name
  }
  for_each = var.subnet_list
}

resource "aws_internet_gateway" "vpc_d_gw" {
  vpc_id = aws_vpc.custom_vpc["vpc-d"].id

  tags = {
    Name = "vpc_d_gateway"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "custom_d_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.custom_subnet["subnet_d_public"].id

  tags = {
    Name = "custom_d_nat"
  }

  depends_on = [aws_internet_gateway.vpc_d_gw]
}