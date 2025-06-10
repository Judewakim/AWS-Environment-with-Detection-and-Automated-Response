##############################################
# IAM RULES
##############################################

resource "aws_config_config_rule" "iam_password_policy" {
  count = var.enable_config && var.enable_iam_config ? 1 : 0
  name   = "iam-password-policy"
  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "root_account_mfa_enabled" {
  count = var.enable_config && var.enable_iam_config ? 1 : 0
  name   = "root-account-mfa-enabled"
  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "mfa_for_iam_console_access" {
  count = var.enable_config && var.enable_iam_config ? 1 : 0
  name   = "mfa-for-iam-console-access"
  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "iam_user_no_policies_check" {
  count = var.enable_config && var.enable_iam_config ? 1 : 0
  name   = "iam-user-no-policies-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "iam_user_group_membership_check" {
  count = var.enable_config && var.enable_iam_config ? 1 : 0
  name   = "iam-user-group-membership-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# S3 RULES
##############################################

resource "aws_config_config_rule" "s3_bucket_public_write_prohibited" {
  count = var.enable_config && var.enable_s3_config ? 1 : 0
  name   = "s3-bucket-public-write-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "s3_bucket_encryption_enabled" {
  count = var.enable_config && var.enable_s3_config ? 1 : 0
  name   = "s3-bucket-encryption-enabled"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_ENCRYPTION_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "s3_bucket_logging_enabled" {
  count = var.enable_config && var.enable_s3_config ? 1 : 0
  name   = "s3-bucket-logging-enabled"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# EC2 RULES
##############################################

resource "aws_config_config_rule" "ebs_encryption_by_default" {
  count = var.enable_config && var.enable_ec2_config ? 1 : 0
  name   = "ebs-encryption-by-default"
  source {
    owner             = "AWS"
    source_identifier = "EBS_ENCRYPTION_BY_DEFAULT"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "ec2_instance_no_public_ip" {
  count = var.enable_config && var.enable_ec2_config ? 1 : 0
  name   = "ec2-instance-no-public-ip"
  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# RDS RULES
##############################################

resource "aws_config_config_rule" "rds_storage_encrypted" {
  count = var.enable_config && var.enable_rds_config ? 1 : 0
  name   = "rds-storage-encrypted"
  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "rds_multi_az_support" {
  count = var.enable_config && var.enable_rds_config ? 1 : 0
  name   = "rds-multi-az-support"
  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# CLOUDFRONT / CLOUDTRAIL / LOGGING RULES
##############################################

resource "aws_config_config_rule" "cloud_trail_enabled" {
  count = var.enable_config && var.enable_cloudwatchcloudtrail_config ? 1 : 0
  name   = "cloud-trail-enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "cloud_trail_log_file_validation_enabled" {
  count = var.enable_config && var.enable_cloudwatchcloudtrail_config ? 1 : 0
  name   = "cloud-trail-log-file-validation-enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "cloud_trail_encryption_enabled" {
  count = var.enable_config && var.enable_cloudwatchcloudtrail_config ? 1 : 0
  name   = "cloud-trail-encryption-enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# CLOUDFRONT / CLOUDWATCH LOG RULES
##############################################

resource "aws_config_config_rule" "cw_loggroup_retention_period_check" {
  count = var.enable_config && var.enable_cloudfrontcloudwatch_config ? 1 : 0
  name   = "cw-loggroup-retention-period-check"
  source {
    owner             = "AWS"
    source_identifier = "CW_LOGGROUP_RETENTION_PERIOD_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::Logs::LogGroup"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

resource "aws_config_config_rule" "cw_loggroup_encrypted" {
  count = var.enable_config && var.enable_cloudfrontcloudwatch_config ? 1 : 0
  name   = "cw-loggroup-encrypted"
  source {
    owner             = "AWS"
    source_identifier = "CW_LOGGROUP_ENCRYPTED"
  }
  scope {
    compliance_resource_types = ["AWS::Logs::LogGroup"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# ACM RULES
##############################################

resource "aws_config_config_rule" "acm_certificate_expiration_check" {
  count = var.enable_config && var.enable_acm_config ? 1 : 0
  name   = "acm-certificate-expiration-check"
  source {
    owner             = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# ALB RULES
##############################################

resource "aws_config_config_rule" "alb_http_to_https_redirection_check" {
  count = var.enable_config && var.enable_alb_config ? 1 : 0
  name   = "alb-http-to-https-redirection-check"
  source {
    owner             = "AWS"
    source_identifier = "ALB_HTTP_TO_HTTPS_REDIRECTION_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancingV2::LoadBalancer"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}

##############################################
# VPC RULES
##############################################

resource "aws_config_config_rule" "vpc_flow_logs_enabled" {
  count = var.enable_config && var.enable_vpc_config ? 1 : 0
  name   = "vpc-flow-logs-enabled"
  source {
    owner             = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::VPC"]
  }
  depends_on = [
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]
}
