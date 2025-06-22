//services enabled
output "guardduty_enabled" {
  description = "Boolean flag indicating whether GuardDuty is enabled."
  value       = var.enable_guardduty
}

output "config_enabled" {
  description = "Boolean flag indicating whether AWS Config is enabled."
  value       = var.enable_config
}

output "securityhub_enabled" {
  description = "Boolean flag indicating whether AWS Security Hub is enabled."
  value       = var.enable_securityhub
}


//config
output "config_bucket_name" {
  description = "S3 bucket used by AWS Config to store configuration history and snapshots."
  value       = try(var.log_bucket_name, null)
}

output "config_role_arn" {
  description = "IAM role used by AWS Config."
  value = aws_iam_role.config_role.arn
}



output "enabled_security_standards" {
  description = "List of Security Hub compliance standards enabled in this deployment."
  value = var.enable_securityhub ? [
    "CIS AWS Foundations Benchmark v1.2.0",
    "AWS Foundational Security Best Practices v1.0.0",
    "PCI DSS v3.2.1"
  ] : []
}





//guardduty
output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector, if enabled."
  value       = try(aws_guardduty_detector.securityhub_account.id, null)
}

//security hub
output "securityhub_account_id" {
  description = "Security Hub account resource ID (not the AWS account ID)."
  value = (
    length(aws_securityhub_account.securityhub_account) > 0
    ? aws_securityhub_account.securityhub_account[0].id
    : null
  )
}

output "securityhub_summary" {
  value = {
    securityhub_enabled = var.enable_securityhub
    enabled_standards   = var.enable_securityhub ? [
      "CIS v1.2.0",
      "AWS Best Practices v1.0.0",
      "PCI DSS v3.2.1"
    ] : []
  }
}

//cloudtrail
output "cloudtrail_arn" {
  value       = var.enable_cloudtrail ? aws_cloudtrail.securecloud_trail[0].arn : null
  description = "ARN of the CloudTrail trail"
}

output "cloudtrail_name" {
  value       = var.enable_cloudtrail ? aws_cloudtrail.securecloud_trail[0].name : null
  description = "Name of the CloudTrail trail"
}
