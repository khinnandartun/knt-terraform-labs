output "private_ip_instance_a" {
  value = aws_instance.knt_instance["instance_a"].private_ip

}

output "private_ip_instance_b" {
  value = aws_instance.knt_instance["instance_b"].private_ip

}

output "private_ip_instance_c" {
  value = aws_instance.knt_instance["instance_c"].private_ip

}


output "private_ip_instance_d" {
  value = aws_instance.knt_instance["instance_d"].private_ip

} 

output "public_ip_instance_d" {
  value = aws_instance.knt_instance["instance_d"].public_ip

}
