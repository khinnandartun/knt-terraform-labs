resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_vpc_gw.id
  }

  tags = {
    Name = "public-rt"
  }

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_vpc_nat.id
  }

  tags = {
    Name = "private-rt"
  }

}

resource "aws_route_table" "isolated_private_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "isolated_private-rt"
  }

}

resource "aws_route_table_association" "public_subnet_1c_rt_association" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet_2b_rt_association" {
  subnet_id      = aws_subnet.public_subnet_2b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_b_rt_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "isolated_private_subnet_rt_association" {
  subnet_id      = aws_subnet.isolated_private_subnet.id
  route_table_id = aws_route_table.isolated_private_rt.id
}

