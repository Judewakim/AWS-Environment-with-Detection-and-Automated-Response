resource "aws_s3_bucket" "config_logs" {
  bucket = "${var.project_prefix}-config.logs"
  force_destroy = true

  tags = {
    Name = "AWS Config Logs"
    Environment = var.environment 
  }
}

resource "aws_s3_bucket_versioning" "config_logs" {
  bucket = aws_s3_bucket.config_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "config_logs" {
  bucket = aws_s3_bucket.config_logs.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "config_role" {
  name = "${var.project_prefix}-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = {
        Service = "config.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
  tags = {
    Name = "AWS Config Role"
  }
}

resource "aws_iam_role_policy_attachment" "config_policy_attach" {
  role = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = "config-recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported = true //is the default option
    include_global_resource_types = true //requires all_supported = true
  }

  depends_on = [ aws_iam_role_policy_attachment.config_policy_attach ]
}

resource "aws_config_delivery_channel" "delivery" {
  name = "config-recorder"
  s3_bucket_name = aws_s3_bucket.config_logs.bucket

  depends_on = [ aws_config_configuration_recorder.recorder ]
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name = aws_config_configuration_recorder.recorder.name
  is_enabled = true
}