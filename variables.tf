variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2" # Default region
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
