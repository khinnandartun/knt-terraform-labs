resource "aws_key_pair" "knt_mac_key" {
  key_name   = "knt-mac-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCba7c9YylRzE+4Tdikxd77JZLgUg0YN6RzTUHVPjOeEOvi0XsAn3J9dVixkyr6FywTZpaXueR+e3mBJ006MPnTLbTTKuYFt8f92RzEvJ1IqMwmj5ARKuRfAkLUHMvi+emhZXTgK3xoTtdsnIFovMIY+7ldr44emkbDCajlaCSkrnBpROMtsRoGB4BBpMrKYJ1zUBDNbL9wgH3/J4FTMnCaIUkg4ECywoEdDaubylKhF+kCy9QlEwKO8Ev8wlV+YJjI6HcjUCv8y9d7e0xP/iv22Sdaj4g/lXEJLGbIkjlUxN2O2uXudgoGL01dZnltqpliHQ0nxQVBrgnhRWT8tEQKPA/VeEsVD4Zt6FpiyL5FhLncroVoiJDa7axJ8BxuTScalCb4vssglNX4ug5iZuJFEpC8ohyxFwEC/lIvIPPTz84EQsmVF8dUoicuClLlNjIfc7GK7JW0u6ItxgTOteUHAObVwLBmpj6ej+lDbbTJvFW2V2M2mtAaQ4RSz2DTKxc= knt@mac"
  tags = {
    Name = "knt_mac_key"
  }
}
resource "aws_security_group" "ssh_allow_sg" {
  name        = each.value.sg_name
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.custom_vpc[each.value.vpc_name].id

  ingress {
    description = "TLS to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = each.value.cidr_block_list
  }
  ingress {
    description = "ping  from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = each.value.cidr_block_list

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.value.sg_name
  }
  for_each = var.sg_list
}

resource "aws_instance" "knt_instance" {
  ami                         = "ami-0eeadc4ab092fef70"
  instance_type               = "t2.micro"
  key_name                    = "knt-mac-key"
  subnet_id                   = aws_subnet.custom_subnet[each.value.subnet_name].id
  vpc_security_group_ids      = [aws_security_group.ssh_allow_sg[each.value.sg_name].id]
  associate_public_ip_address = each.value.public_access
  tags = {
    Name = each.value.instance_name
  }
  for_each = var.instance_list
}