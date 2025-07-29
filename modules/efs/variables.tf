variable "file_system_name" {
  description = "The name of the EFS file system."
  type        = string
}

variable "throughput_mode" {
  description = "The throughput mode for the EFS file system."
  type        = string
  default     = "bursting"
}

variable "performance_mode" {
  description = "The performance mode for the EFS file system."
  type        = string
  default     = "generalPurpose"
}

variable "lifecycle_policy" {
  description = "The lifecycle policy for the EFS file system."
  type        = list(string)
  default     = ["AFTER_7_DAYS"]
}