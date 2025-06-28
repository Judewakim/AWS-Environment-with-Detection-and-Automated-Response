##############################################
# User Groups
##############################################

resource "aws_iam_group" "admin_group" {
  count = var.enable_iam && var.enable_admin_group ? 1 : 0
  name = "AdminGroup"
}

resource "aws_iam_group" "sales_group" {
  count = var.enable_iam && var.enable_sales_group ? 1 : 0
  name = "SalesGroup"
}

resource "aws_iam_group" "accounting_group" {
  count = var.enable_iam && var.enable_accounting_group ? 1 : 0
  name = "AccountingGroup"
}


##############################################
# Group Policies
##############################################

resource "aws_iam_policy" "admin_group_policy" {
  count = var.enable_iam && var.enable_admin_group ? 1 : 0
  name        = "AdminGroupPolicy"
  description = "Full administrative access."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "sales_group_policy" {
  count = var.enable_iam && var.enable_sales_group ? 1 : 0
  name        = "SalesGroupPolicy"
  description = "Read-only access to customer-related data."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:ListBucket",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "cloudwatch:GetMetricData"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "accounting_group_policy" {
  count = var.enable_iam && var.enable_accounting_group ? 1 : 0
  name        = "AccountingGroupPolicy"
  description = "Billing and cost management permissions."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "budgets:*",
          "aws-portal:ViewBilling",
          "aws-portal:ViewUsage",
          "ce:Get*",
          "ce:List*"
        ],
        Resource = "*"
      }
    ]
  })
}

##############################################
# Policy Attachments
##############################################

resource "aws_iam_group_policy_attachment" "admin_group_attach" {
  count = var.enable_iam && var.enable_admin_group ? 1 : 0
  group      = aws_iam_group.admin_group[0].name
  policy_arn = aws_iam_policy.admin_group_policy[0].arn
}

resource "aws_iam_group_policy_attachment" "sales_group_attach" {
  count = var.enable_iam && var.enable_sales_group ? 1 : 0
  group      = aws_iam_group.sales_group[0].name
  policy_arn = aws_iam_policy.sales_group_policy[0].arn
}

resource "aws_iam_group_policy_attachment" "accounting_group_attach" {
  count = var.enable_iam && var.enable_accounting_group ? 1 : 0
  group      = aws_iam_group.accounting_group[0].name
  policy_arn = aws_iam_policy.accounting_group_policy[0].arn
}