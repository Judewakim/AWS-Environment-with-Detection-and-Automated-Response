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

  #ensure that Security Hub isn’t enabled unless one of its sources (like Config or GuardDuty) is enabled
  validation {
    condition     = !var.enable_securityhub || var.enable_config || var.enable_guardduty
    error_message = "SecurityHub requires at least one source of findings (Config or GuardDuty) to be enabled."
  }
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
