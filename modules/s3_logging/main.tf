#used for CloudTrail logs, Config logs, GuardDuty findings

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-sec-logs-${random_id.rand.hex}"
  force_destroy = true
}

resource "random_id" "rand" {
  byte_length = 4
}
