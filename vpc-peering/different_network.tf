resource "aws_vpc" "different_vpc" {
  cidr_block           = var.different_vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "different_vpc"
  }
}

resource "aws_subnet" "different_private_subnet_b" {
  vpc_id            = aws_vpc.different_vpc.id
  cidr_block        = var.differnet_private_subnet_cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "different_private_subnet_b"
  }
}

resource "aws_vpc_peering_connection" "peering_test" {
  peer_vpc_id = aws_vpc.custom_vpc.id
  vpc_id      = aws_vpc.different_vpc.id
  auto_accept = true
  tags = {
    Name = "peering_test"
  }
}

resource "aws_route_table" "different_private_rt" {
  vpc_id = aws_vpc.different_vpc.id
  tags = {
    Name = "different_private_rt"
  }

}

resource "aws_route_table_association" "different_private_rt_association" {
  subnet_id      = aws_subnet.different_private_subnet_b.id
  route_table_id = aws_route_table.different_private_rt.id
}

resource "aws_route" "different_private_to_custom_private" {
  route_table_id            = aws_route_table.different_private_rt.id
  destination_cidr_block    = var.private_subnet_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_test.id
  depends_on                = [aws_route_table.different_private_rt]
}

resource "aws_route" "custom_private_to_different_private" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = var.differnet_private_subnet_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_test.id
  depends_on                = [aws_route_table.private_rt,aws_vpc_peering_connection.peering_test]
}
