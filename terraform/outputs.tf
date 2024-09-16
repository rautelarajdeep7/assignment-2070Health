output "public_key" {
  value = tls_private_key.key-generate.public_key_openssh
}

output "ec2-public-ip" {
  value = aws_instance.ec2.public_ip
}

output "ec2-public-dns" {
  value = aws_instance.ec2.public_dns
}
