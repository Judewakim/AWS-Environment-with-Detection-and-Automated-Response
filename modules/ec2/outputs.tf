output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

