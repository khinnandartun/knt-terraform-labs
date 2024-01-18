resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc["vpc-d"].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_d_gw.id
  }
  route {
    cidr_block         = "10.10.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }

  route {
    cidr_block         = "10.11.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }

  route {
    cidr_block         = "10.12.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }


  tags = {
    Name = "public-rt"
  }

}
resource "aws_route_table_association" "public_subnet_d_public_rt_association" {
  subnet_id      = aws_subnet.custom_subnet["subnet_d_public"].id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc["vpc-d"].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.custom_d_nat.id
  }

  tags = {
    Name = "private-rt"
  }

}
resource "aws_route_table_association" "private_subnet_d_public_rt_association" {
  subnet_id      = aws_subnet.custom_subnet["subnet_d_private"].id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.custom_vpc["vpc-a"].id
  route {
    cidr_block = "0.0.0.0/0"
     transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }

  tags = {
    Name = "private-rt-a"
  }

}
resource "aws_route_table_association" "public_subnet_a_rt_association" {
  subnet_id      = aws_subnet.custom_subnet["subnet_a"].id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.custom_vpc["vpc-b"].id
  route {
    cidr_block = "0.0.0.0/0"
     transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }

  tags = {
    Name = "private-rt-b"
  }

}
resource "aws_route_table_association" "public_subnet_b_rt_association" {
  subnet_id      = aws_subnet.custom_subnet["subnet_b"].id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route_table" "private_rt_c" {
  vpc_id = aws_vpc.custom_vpc["vpc-c"].id
  route {
    cidr_block = "0.0.0.0/0"
     transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  }


  tags = {
    Name = "private-rt-c"
  }

}
resource "aws_route_table_association" "public_subnet_c_rt_association" {
  subnet_id      = aws_subnet.custom_subnet["subnet_c"].id
  route_table_id = aws_route_table.private_rt_c.id
}