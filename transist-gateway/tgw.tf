resource "aws_ec2_transit_gateway" "test_tgw" {
  description                    = "transist gateway testing"
  auto_accept_shared_attachments = "enable"
  tags = {
    Name = "test-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_a_attachment" {
  subnet_ids         = [aws_subnet.custom_subnet["subnet_a"].id]
  transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  vpc_id             = aws_vpc.custom_vpc["vpc-a"].id
  tags = {
    Name = "tgw_vpc_a_attachment"
  }
}


resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_b_attachment" {
  subnet_ids         = [aws_subnet.custom_subnet["subnet_b"].id]
  transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  vpc_id             = aws_vpc.custom_vpc["vpc-b"].id
  tags = {
    Name = "tgw_vpc_b_attachment"
  }
}


resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_c_attachment" {
  subnet_ids         = [aws_subnet.custom_subnet["subnet_c"].id]
  transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  vpc_id             = aws_vpc.custom_vpc["vpc-c"].id
  tags = {
    Name = "tgw_vpc_c_attachment"
  }
}


resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_d_attachment" {
  subnet_ids         = [aws_subnet.custom_subnet["subnet_d_private"].id]
  transit_gateway_id = aws_ec2_transit_gateway.test_tgw.id
  vpc_id             = aws_vpc.custom_vpc["vpc-d"].id
  tags = {
    Name = "tgw_vpc_d_attachment"
  }
}


resource "aws_ec2_transit_gateway_route" "internet_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_d_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.test_tgw.association_default_route_table_id
}