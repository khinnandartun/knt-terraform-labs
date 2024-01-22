resource "aws_key_pair" "knt_mac" {
  key_name   = "knt-mac-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9EK+IzY0BCje4xDAI3XZdu9YNE26QusDHog2fuv5fRg3Oeg288Cwo+AC8b1QCbQSFhmJsp/o1PX3wPwytEQCAmaX6T4NjVkT70kDfC4pX7ib34x2Gft384UpABm3dUh/VbqHFHj30dLZfTrZ/NrSI0DL5QiIqtKYYXgwaCR1R2utch72f8/nU+A38Um8nKA7EFi9z76UsGmjQ2F5UFp+KP0MZFbTDlwyez5wQcGykFdSzYD7hixWxnGypHUFeLartO/rvX2sCil08YZE+3R38QQqhbYQjgpGSj5saLfOmZWSwlu/lLpCgtP9pET50ic1/O7p2oPpPNna2mV/DcnN5FpzZLxMO1RPrbd/a8IHgGTJ8f3TqJvgq6DNX+kSa2tc+YbfYUKEdKwAiBfHuwGkifEjhtlcxuDB+XTarMBbD3bkYHCJ5aYrpgk0QNbcXk10HAQ06Nem7x61ufTTGmFfJx693+YWSJzOUU+jdnZv+Dqda2h/92ofrp0vYH5tC0DU= knt@mac"
  tags = {
    Name = "knt_mac_key"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_ssh_different" {
  name        = "allow_ssh_different"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.different_vpc.id

  ingress {
    description = "TLS to VPC"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "knt_public" {
  ami                         = "ami-0eeadc4ab092fef70"
  instance_type               = "t2.micro"
  key_name                    = "knt-mac-key"
  subnet_id                   = aws_subnet.public_subnet_2b.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "knt_public"
  }
}

resource "aws_instance" "knt_private" {
  ami                    = "ami-0eeadc4ab092fef70"
  instance_type          = "t2.micro"
  key_name               = "knt-mac-key"
  subnet_id              = aws_subnet.private_subnet_b.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "knt_private"
  }
}


resource "aws_instance" "knt_different_private" {
  ami                    = "ami-0eeadc4ab092fef70"
  instance_type          = "t2.micro"
  key_name               = "knt-mac-key"
  subnet_id              = aws_subnet.different_private_subnet_b.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_different.id]
  tags = {
    Name = "knt_different_private"
  }
}
