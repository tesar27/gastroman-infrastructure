variable "db_name" {
  description = "Database name for MariaDB"
  type        = string
  default     = "gastroman"
}

variable "db_admin_username" {
  description = "Admin username for MariaDB"
  type        = string
  default     = "admin"
}

variable "db_admin_password" {
  description = "Admin password for MariaDB"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_admin_password) >= 8
    error_message = "db_admin_password must be at least 8 characters long."
  }
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial allocated storage for MariaDB (GiB)"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "MariaDB engine version"
  type        = string
  default     = "10.11"
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  description = "Enable deletion protection on RDS instance"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot when destroying RDS instance"
  type        = bool
  default     = true
}
