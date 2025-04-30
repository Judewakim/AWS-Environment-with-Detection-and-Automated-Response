variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_id" {
  type        = string
  description = "Public Subnet ID"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for EC2 instances"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "my_ip" {
  type        = string
  description = "Public IP in CIDR format"
}
