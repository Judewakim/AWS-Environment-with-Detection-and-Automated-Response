#used for CloudTrail logs, Config logs, GuardDuty findings

resource "aws_s3_bucket" "config_logs" {
  bucket = "${var.project_prefix}-config.logs"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "config_logs" {
  bucket = aws_s3_bucket.config_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config_logs" {
  bucket = aws_s3_bucket.config_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "config_logs" {
  bucket = aws_s3_bucket.config_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config_logs_policy" {
  bucket = aws_s3_bucket.config_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSConfigBucketPermissionsCheck",
        Effect    = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action    = "s3:GetBucketAcl",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.config_logs.id}"
      },
      {
        Sid       = "AWSConfigBucketDelivery",
        Effect    = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action    = "s3:PutObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.config_logs.id}/config/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
