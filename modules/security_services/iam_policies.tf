
#######################
# task policies
#######################

resource "aws_iam_policy" "ec2_start_stop" {
  count = var.enable_iam && var.enable_ec2_start_stop_policy ? 1 : 0
  name        = "EC2StartStopPolicy"
  description = "Allows starting and stopping of EC2 instances."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "rds_read_only" {
  count = var.enable_iam && var.enable_rds_read_only_policy ? 1 : 0
  name        = "RDSReadOnlyPolicy"
  description = "Provides read-only access to RDS."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds:Describe*"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_read_write" {
  count = var.enable_iam && var.enable_s3_read_write_policy ? 1 : 0
  name        = "S3ReadWritePolicy"
  description = "Allows read/write access to S3 buckets."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_read_only" {
  count = var.enable_iam && var.enable_s3_read_only_policy ? 1 : 0
  name        = "S3ReadOnlyPolicy"
  description = "Read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "billing_read_only" {
  count = var.enable_iam && var.enable_billing_read_only_policy ? 1 : 0
  name        = "BillingReadOnlyPolicy"
  description = "Read access to billing and cost explorer"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "aws-portal:ViewBilling",
          "ce:Get*",
          "ce:List*"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "securityhub_read_only" {
  count = var.enable_iam && var.enable_securityhub_read_only_policy ? 1 : 0
  name        = "SecurityHubReadOnlyPolicy"
  description = "Allows viewing Security Hub findings"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "securityhub:GetFindings",
          "securityhub:Describe*",
          "securityhub:List*"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}



#########################################
# account policies
#########################################

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_symbols                = true
  require_numbers                = true
  require_uppercase_characters  = true
  require_lowercase_characters  = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24
  hard_expiry                    = true
}

