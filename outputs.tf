#output VPC ID

#output public IP of bastion (if used)

#S3 bucket name

#SNS topic ARN

output "securityhub_summary" {
  value = module.security_services.securityhub_summary
}
