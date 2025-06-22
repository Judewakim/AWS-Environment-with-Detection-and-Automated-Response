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
  name = "${var.project_prefix}-delivery"
  s3_bucket_name = var.centralized_log_bucket
  s3_key_prefix = "config/"

  depends_on = [ aws_config_configuration_recorder.recorder ]
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name = aws_config_configuration_recorder.recorder.name
  is_enabled = true
}

resource "aws_iam_role" "config_role" {
  name = "${var.project_prefix}-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "config_policy_attach" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}
