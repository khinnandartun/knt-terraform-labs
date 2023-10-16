# resource "aws_key_pair" "knt_mac" {
#   key_name   = "knt-mac-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCba7c9YylRzE+4Tdikxd77JZLgUg0YN6RzTUHVPjOeEOvi0XsAn3J9dVixkyr6FywTZpaXueR+e3mBJ006MPnTLbTTKuYFt8f92RzEvJ1IqMwmj5ARKuRfAkLUHMvi+emhZXTgK3xoTtdsnIFovMIY+7ldr44emkbDCajlaCSkrnBpROMtsRoGB4BBpMrKYJ1zUBDNbL9wgH3/J4FTMnCaIUkg4ECywoEdDaubylKhF+kCy9QlEwKO8Ev8wlV+YJjI6HcjUCv8y9d7e0xP/iv22Sdaj4g/lXEJLGbIkjlUxN2O2uXudgoGL01dZnltqpliHQ0nxQVBrgnhRWT8tEQKPA/VeEsVD4Zt6FpiyL5FhLncroVoiJDa7axJ8BxuTScalCb4vssglNX4ug5iZuJFEpC8ohyxFwEC/lIvIPPTz84EQsmVF8dUoicuClLlNjIfc7GK7JW0u6ItxgTOteUHAObVwLBmpj6ej+lDbbTJvFW2V2M2mtAaQ4RSz2DTKxc= knt@mac"
#   tags = {
#     Name = "knt_mac_key"
#   }
# }

resource "aws_instance" "knt_rocky_test" {
  ami                         = "ami-0a53f0b509ec63d89" #rocky linux AMI ID for singapore region
  instance_type               = "t3.small"
  key_name                    = "knt-mac"
  subnet_id                   = "subnet-01f1749ec20a33ff3"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-0b3d40cccbde49851"]
  count = var.total_vm
  tags = {
    Name = "knt-rocky-test-${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.knt_rocky_test[*].public_ip
  
}

output "private_ip" {
  value = aws_instance.knt_rocky_test[*].private_ip
  
}