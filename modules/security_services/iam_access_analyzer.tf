resource "aws_accessanalyzer_analyzer" "main" {
  analyzer_name = "${var.project_prefix}-access-analyzer"
  type          = "ACCOUNT"
}