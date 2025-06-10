locals {
  securityhub_dependencies = concat(
    [aws_securityhub_account.securityhub_account],
    var.enable_config ? tolist([
    aws_config_configuration_recorder.recorder,
    aws_config_delivery_channel.delivery
  ]) : tolist([]),
    var.enable_guardduty ? [
      aws_guardduty_detector.securityhub_account //is it supposed to be ".securityhub_account"?
    ] : []
  )
}
resource "aws_securityhub_account" "securityhub_account" {
    count = var.enable_securityhub ? 1 : 0
}

resource "aws_securityhub_standards_subscription" "cis_1_2_0" {
  count = var.enable_securityhub ? 1 : 0
  standards_arn = "arn:aws:securityhub:${var.aws_region}::standards/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on = [local.securityhub_dependencies]
}

resource "aws_securityhub_standards_subscription" "security_best_practices" {
  count = var.enable_securityhub ? 1 : 0
  standards_arn = "arn:aws:securityhub:${var.aws_region}::standards/aws-foundational-security-best-practices/v/1.0.0"
  depends_on = [local.securityhub_dependencies]
}

resource "aws_securityhub_standards_subscription" "pci_3_2_1" {
  count = var.enable_securityhub ? 1 : 0
  standards_arn = "arn:aws:securityhub:${var.aws_region}::standards/pci-dss/v/3.2.1"
  depends_on = [local.securityhub_dependencies]
}