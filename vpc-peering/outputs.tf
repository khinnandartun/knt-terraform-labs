output "public_knt_public_ip" {
  value     = aws_instance.knt_public.public_ip
  sensitive = false
}

output "private_knt_private_ip" {
  value     = aws_instance.knt_private.private_ip
  sensitive = false
}
output "private_knt_different_private_ip" {
  value     = aws_instance.knt_different_private.private_ip
  sensitive = false
}