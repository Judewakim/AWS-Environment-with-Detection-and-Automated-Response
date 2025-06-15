variable "project_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  default = "us-east-1"
}

#enabling services
variable "enable_config" {
  type    = bool
  default = false
}

variable "enable_securityhub" {
  type    = bool
  default = false
}

variable "enable_guardduty" {
  type    = bool
  default = false
}

#enabling config rules
variable "enable_iam_config" {
  type    = bool
  default = false
}

variable "enable_s3_config" {
  type    = bool
  default = false
}

variable "enable_ec2_config" {
  type    = bool
  default = false
}

variable "enable_rds_config" {
  type    = bool
  default = false
}

variable "enable_cloudwatchcloudtrail_config" {
  type    = bool
  default = false
}

variable "enable_cloudfrontcloudwatch_config" {
  type    = bool
  default = false
}

variable "enable_acm_config" {
  type    = bool
  default = false
}

variable "enable_alb_config" {
  type    = bool
  default = false
}

variable "enable_vpc_config" {
  type    = bool
  default = false
}

## only necessary if 'enable_vpc_config' is called directly from the security_services/variables.tf instead of the root variables.tf (using 'enable_vpc_config = module.security_services.enable_vpc_config')
# variable "enable_vpc_flow_logs_config_rule" {
#   description = "Enable AWS Config rule to check VPC Flow Logs"
#   type        = bool
#   default     = false
# }

