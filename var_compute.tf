variable "gastroman_web_server_instance_type" {
  description = "(Optional) Instance type for the web server"
  type        = string
  default     = "t3.micro"
}
variable "iam_instance_profile" {
  description = "IAM instance profile for the web server"
  type        = string
  default     = null
}
