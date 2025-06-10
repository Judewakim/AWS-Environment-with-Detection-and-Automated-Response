output "config_bucket_name" {
  description = "S3 bucket used by AWS Config to store configuration history and snapshots."
  value       = try(aws_s3_bucket.config_logs.bucket, null)
}

output "config_role_arn" {
  description = "IAM role used by AWS Config."
  value       = try(aws_iam_role.config_role.arn, null)
}

output "securityhub_enabled" {
  description = "Boolean flag indicating whether AWS Security Hub is enabled."
  value       = var.enable_securityhub
}

output "enabled_security_standards" {
  description = "List of Security Hub compliance standards enabled in this deployment."
  value = var.enable_securityhub ? [
    "CIS AWS Foundations Benchmark v1.2.0",
    "AWS Foundational Security Best Practices v1.0.0",
    "PCI DSS v3.2.1"
  ] : []
}

output "guardduty_enabled" {
  description = "Boolean flag indicating whether GuardDuty is enabled."
  value       = var.enable_guardduty
}

output "config_enabled" {
  description = "Boolean flag indicating whether AWS Config is enabled."
  value       = var.enable_config
}

output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector, if enabled."
  value       = try(aws_guardduty_detector.this.id, null)
}

output "securityhub_account_id" {
  description = "Security Hub account resource ID (not the AWS account ID)."
  value       = try(aws_securityhub_account.securityhub_account.id, null)
}
