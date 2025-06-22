variable "project_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}