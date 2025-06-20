resource "aws_cloudtrail" "securecloud_trail" {
  name                          = "securecloud-trail"
  s3_bucket_name                = var.security_log_bucket_name
  s3_key_prefix                 = "cloudtrail/"
  include_global_service_events = true
  is_multi_region_trail         = var.cloudtrail_all_regions
  enable_log_file_validation    = true
  is_organization_trail         = var.cloudtrail_org_trail
  enable_logging                = true

  cloud_watch_logs_group_arn    = null
  cloud_watch_logs_role_arn     = null

  enable_insight_selectors = var.cloudtrail_enable_insights

  dynamic "insight_selector" {
    for_each = var.cloudtrail_enable_insights ? [1] : []
    content {
      insight_type = "ApiCallRateInsight"
    }
  }

  depends_on = [aws_s3_bucket_policy.security_log_bucket_policy]
}
