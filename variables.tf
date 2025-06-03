variable "aws_region" {
  default = "us-east-1"
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  default = "playground-dbname"
}