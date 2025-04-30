resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "${path.module}/bastion-key.pem"
  content         = tls_private_key.bastion.private_key_pem
  file_permission = "0600"
}
