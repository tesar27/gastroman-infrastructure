variable "aws_profile" {
  description = "(Optional) AWS profile to use for deployment"
  type        = string
  default     = null
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2" # Default region
}
