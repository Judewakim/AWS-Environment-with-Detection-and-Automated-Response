resource "aws_cloudtrail" "securecloud_trail" {

  count = var.enable_cloudtrail ? 1 : 0

  name                          = "${var.project_prefix}-securecloud"
  s3_bucket_name                = var.log_bucket_name
  s3_key_prefix                 = "cloudtrail/"

  include_global_service_events = var.global_service_events
  is_multi_region_trail         = var.cloudtrail_all_regions
  is_organization_trail         = var.cloudtrail_org_trail
  enable_log_file_validation    = true
  enable_logging                = true

  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role[0].arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail_log_group[0].arn}:*"

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"] # Logs all S3 bucket access
    }

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"] # Logs all Lambda function invocations
    }
  }

  dynamic "insight_selector" {
    for_each = var.cloudtrail_enable_insights ? [1] : []
    content {
      insight_type = "ApiCallRateInsight"
    }
  }

  depends_on = [var.bucket_name]
}

resource "aws_cloudwatch_log_group" "cloudtrail_log_group" {
  count = var.enable_cloudtrail ? 1 : 0

  name              = "/aws/cloudtrail/${var.project_prefix}"
  retention_in_days = 90
}

resource "aws_iam_role" "cloudtrail_role" {
  count = var.enable_cloudtrail ? 1 : 0

  name = "${var.project_prefix}-cloudtrail-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "cloudtrail_policy" {
  count = var.enable_cloudtrail ? 1 : 0

  name = "${var.project_prefix}-cloudtrail-policy"
  role = aws_iam_role.cloudtrail_role[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream"
        ]
        Resource = "${aws_cloudwatch_log_group.cloudtrail_log_group[0].arn}:*"
      }
    ]
  })
}
