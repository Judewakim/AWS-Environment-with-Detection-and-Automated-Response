############Admin Group##################
resource "aws_iam_group" "admin" {
  count = var.enable_admin_group ? 1 : 0
  name  = "AdminGroup"
}

resource "aws_iam_policy" "admin_policy" {
  count = var.enable_admin_group ? 1 : 0
  name        = "AdminGroupPolicy"
  description = "Provides full administrative access."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "admin_policy_attach" {
  count      = var.enable_admin_group ? 1 : 0
  group      = aws_iam_group.admin[0].name
  policy_arn = aws_iam_policy.admin_policy[0].arn
}

######################Accounting Group################
resource "aws_iam_group" "accounting" {
  count = var.enable_accounting_group ? 1 : 0
  name  = "AccountingGroup"
}

resource "aws_iam_policy" "accounting_policy" {
  count = var.enable_accounting_group ? 1 : 0
  name        = "AccountingGroupPolicy"
  description = "Provides access to billing and cost management."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "aws-portal:*",
          "ce:*",
          "budgets:*",
          "cur:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "accounting_policy_attach" {
  count      = var.enable_accounting_group ? 1 : 0
  group      = aws_iam_group.accounting[0].name
  policy_arn = aws_iam_policy.accounting_policy[0].arn
}

########Sales Group###########
resource "aws_iam_group" "sales" {
  count = var.enable_sales_group ? 1 : 0
  name  = "SalesGroup"
}

resource "aws_iam_policy" "sales_policy" {
  count = var.enable_sales_group ? 1 : 0
  name        = "SalesGroupPolicy"
  description = "Provides limited read-only access to customer data."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "dynamodb:Query",
          "dynamodb:GetItem"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "sales_policy_attach" {
  count      = var.enable_sales_group ? 1 : 0
  group      = aws_iam_group.sales[0].name
  policy_arn = aws_iam_policy.sales_policy[0].arn
}
