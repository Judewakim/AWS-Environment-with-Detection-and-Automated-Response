module "network" {
  source            = "./modules/network"
  availability_zone = "us-east-1a"
}


module "s3_logging" {
  source = "./modules/s3_logging"
}

module "security_services" {
  source          = "./modules/security_services"
  log_bucket_name = module.s3_logging.bucket_name
}

module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  instance_type    = "t2.micro"
  ami_id           = "ami-0b86aaed8ef90e45f" #Amazon Linux 2 AMI
  key_name         = aws_key_pair.bastion_key.key_name
  my_ip = data.external.my_ip.result["ip"]
}

module "sns_alerts" {
  source = "./modules/sns_alerts"
}

data "external" "my_ip" {
  program = ["python3", "${path.module}/scripts/get_my_ip.py"]
}

#cant use bc HTTP gets redirected to HTTPS and Terraform doesnt support HTTPS
# data "http" "my_ip" {
#   url = "http://ifconfig.me"
# }

# locals {
#   my_ip = "${trimspace(data.http.my_ip.response_body)}/32"
# }