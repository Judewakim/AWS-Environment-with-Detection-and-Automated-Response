#ensure that Security Hub isn’t enabled unless one of its sources (like Config or GuardDuty) is enabled
resource "null_resource" "validate_securityhub_dependencies" {
  count = var.enable_securityhub && !var.enable_config && !var.enable_guardduty ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'ERROR: Security Hub requires AWS Config and/or GuardDuty to be enabled.' && exit 1"
  }
}
