resource "aws_key_pair" "knt_mac" {
  key_name   = "knt-mac-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9EK+IzY0BCje4xDAI3XZdu9YNE26QusDHog2fuv5fRg3Oeg288Cwo+AC8b1QCbQSFhmJsp/o1PX3wPwytEQCAmaX6T4NjVkT70kDfC4pX7ib34x2Gft384UpABm3dUh/VbqHFHj30dLZfTrZ/NrSI0DL5QiIqtKYYXgwaCR1R2utch72f8/nU+A38Um8nKA7EFi9z76UsGmjQ2F5UFp+KP0MZFbTDlwyez5wQcGykFdSzYD7hixWxnGypHUFeLartO/rvX2sCil08YZE+3R38QQqhbYQjgpGSj5saLfOmZWSwlu/lLpCgtP9pET50ic1/O7p2oPpPNna2mV/DcnN5FpzZLxMO1RPrbd/a8IHgGTJ8f3TqJvgq6DNX+kSa2tc+YbfYUKEdKwAiBfHuwGkifEjhtlcxuDB+XTarMBbD3bkYHCJ5aYrpgk0QNbcXk10HAQ06Nem7x61ufTTGmFfJx693+YWSJzOUU+jdnZv+Dqda2h/92ofrp0vYH5tC0DU= knt@mac"
  tags = {
    Name = "knt_mac_key"
  }
}

resource "aws_instance" "knt_rocky_test" {
  ami                         = "ami-0a53f0b509ec63d89" #rocky linux AMI ID for singapore region
  instance_type               = "t3.small"
  key_name                    = "knt-mac-key"
  subnet_id                   = "subnet-01f1749ec20a33ff3"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-0b3d40cccbde49851"]
  tags = {
    Name = "knt-rocky-test"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.knt_rocky_test.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_instance.knt_rocky_test.public_ip
  
}