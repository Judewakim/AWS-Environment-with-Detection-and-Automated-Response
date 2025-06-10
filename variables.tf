//account
variable "aws_region" {
  default = "us-east-1"
}

variable "project_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "wakimworks" //or remove from here and set them in CLI during terraform apply or MOVE TO TFVARS
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
  default     = "dev" //or remove from here and set them in CLI during terraform apply  or MOVE TO TFVARS

}


//rds
variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true // MOVE TO TFVARS
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "playground-dbname" //or remove from here and set them in CLI during terraform apply  or MOVE TO TFVARS

}

variable "availability_zone_1" {
  description = "Availability zone for the subnets"
}

variable "availability_zone_2" {
  description = "Availability zone for the subnets"
}


//enabling services
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
