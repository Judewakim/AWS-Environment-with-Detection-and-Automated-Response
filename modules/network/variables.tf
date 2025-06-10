variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_1" {
  default     = "10.0.2.0/24"
  description = "CIDR block for the private subnet"
}

variable "private_subnet_cidr_2" {
  default     = "10.0.3.0/24"
  description = "CIDR block for the private subnet"
}

variable "availability_zone_1" {
  description = "Availability zone for the subnets"
}

variable "availability_zone_2" {
  description = "Availability zone for the subnets"
}
