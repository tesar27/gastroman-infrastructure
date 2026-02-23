variable "aws_profile" {
  description = "AWS profile for deployment"
  type        = string
  default     = null
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2" # Default region
}
