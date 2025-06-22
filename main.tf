module "network" {
  source = "./modules/network"

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  instance_type    = "t2.micro"
  ami_id           = "ami-0b86aaed8ef90e45f" #Amazon Linux 2 AMI
  key_name         = aws_key_pair.bastion_key.key_name
  my_ip            = data.external.my_ip.result["ip"]
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

module "rds" {
  source = "./modules/rds"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  db_name            = var.db_name
  db_password        = var.db_password
}

module "security_services" {
  source = "./modules/security_services"

  # General config
  aws_region     = var.aws_region
  project_prefix = var.project_prefix
  environment    = var.environment

  # Core service-level toggles
  enable_config      = var.enable_config
  enable_guardduty   = var.enable_guardduty
  enable_securityhub = var.enable_securityhub
  enable_cloudtrail = var.enable_cloudtrail


  # Fine-grained Config rule toggles
  enable_iam_config                  = var.enable_iam_config
  enable_ec2_config                  = var.enable_ec2_config
  enable_rds_config                  = var.enable_rds_config
  enable_cloudwatchcloudtrail_config = var.enable_cloudwatchcloudtrail_config
  enable_cloudfrontcloudwatch_config = var.enable_cloudfrontcloudwatch_config
  enable_acm_config                  = var.enable_acm_config
  enable_alb_config                  = var.enable_alb_config
  enable_vpc_config                  = var.enable_vpc_config 
  # enable_vpc_config = module.security_services.enable_vpc_config

  # Centralized Log Bucket 
  centralized_log_bucket = module.s3_logging.log_bucket_name
  log_bucket_name = var.centralized_log_bucket
  bucket_name = var.centralized_log_bucket

  # IAM Groups
  enable_admin_group = var.enable_admin_group
  enable_accounting_group = var.enable_accounting_group
  enable_sales_group = var.enable_sales_group
}
module "s3_logging" {
  source         = "./modules/s3_logging"

  project_prefix = var.project_prefix
  environment = var.environment
}
