variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_availability_zone_a" {
  type        = string
  description = "value for the availability zone"
  default     = "us-west-2a"
}

variable "aws_availability_zone_b" {
  type        = string
  description = "value for the availability zone"
  default     = "us-west-2b"
}
