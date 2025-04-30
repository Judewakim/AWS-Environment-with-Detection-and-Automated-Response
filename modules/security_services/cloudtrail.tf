# resource "aws_cloudtrail" "main" {
#   name                          = "security-trail"
#   s3_bucket_name                = module.s3_logging.bucket_name
#   include_global_service_events = true
#   is_multi_region_trail         = true
#   enable_log_file_validation    = true
# }
