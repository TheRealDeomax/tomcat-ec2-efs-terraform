variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "listener_port" {
  description = "The port on which the load balancer will listen"
  type        = number
  default     = 8080
}

variable "target_group_port" {
  description = "The port on which the target group will receive traffic"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The interval between health checks in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The timeout for health checks in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The number of consecutive successful health checks required before considering an instance healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "The number of consecutive failed health checks required before considering an instance unhealthy"
  type        = number
  default     = 2
}