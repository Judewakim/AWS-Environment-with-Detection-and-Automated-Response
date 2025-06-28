#########USER ACCOUNT##############
variable "aws_region" {
  default = "us-east-1" //MOVE TO TFVARS
}

variable "project_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}


################RDS######################
variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true // MOVE TO TFVARS
}

variable "db_name" {
  description = "Database name"
  type        = string

}

variable "availability_zone_1" {
  description = "Availability zone for the subnets"
}

variable "availability_zone_2" {
  description = "Availability zone for the subnets"
}


##########CENTRALIZED LOG BUCKET######################
variable "centralized_log_bucket" {
  description = "log bucket for config, guardduty, cloudtrail"
  type        = string

  validation {
    condition     = length(var.centralized_log_bucket) > 0
    error_message = "A valid centralized_log_bucket name must be provided."
  }
}

##############SERVICES#####################
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

variable "enable_cloudtrail" {
  type    = bool
  default = false
}

variable "enable_iam" {
  type    = bool
  default = false
}

variable "enable_iam_access_analyzer" {
  type    = bool
  default = true
}


#############CONFIG RULES###############
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

##########IAM SERVICES###############
variable "enable_admin_group" {
  type    = bool
  default = false
}

variable "enable_accounting_group" {
  type    = bool
  default = false
}

variable "enable_sales_group" {
  type    = bool
  default = false
}

variable "enable_s3_read_write_policy" {
  type    = bool
  default = false
}

variable "enable_ec2_start_stop_policy" {
  type    = bool
  default = false
}

variable "enable_rds_read_only_policy" {
  type    = bool
  default = false
}

variable "enable_s3_read_only_policy" {
  type    = bool
  default = false
}

variable "enable_billing_read_only_policy" {
  type    = bool
  default = false
}

variable "enable_securityhub_read_only_policy" {
  type    = bool
  default = false
}