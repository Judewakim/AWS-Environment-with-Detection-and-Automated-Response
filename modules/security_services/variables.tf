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

variable "security_log_bucket_name" {
  description = "Name of the central security S3 bucket for all services."
  type        = string
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

#cloudtrail services
variable "cloudtrail_org_trail" {
  description = "Whether this is an organization-wide trail (multi-account)."
  type        = bool
  default     = false
}

variable "cloudtrail_all_regions" {
  description = "Whether the trail should log across all AWS regions."
  type        = bool
  default     = true
}

variable "cloudtrail_enable_insights" {
  description = "Enable CloudTrail Insights for unusual API activity."
  type        = bool
  default     = true
}