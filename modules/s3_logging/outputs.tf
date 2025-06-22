output "bucket_name" {
  value = aws_s3_bucket.config_logs.bucket
}

output "log_bucket_name" {
  value = aws_s3_bucket.config_logs.id
}

