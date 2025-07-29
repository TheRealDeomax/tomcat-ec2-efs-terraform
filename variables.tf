variable "region" {
  description = "The AWS region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The EC2 instance type for Tomcat servers"
  type        = string
  default     = "t2.medium"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to access the EC2 instances"
  type        = string
}

variable "efs_performance_mode" {
  description = "The performance mode for the EFS file system"
  type        = string
  default     = "generalPurpose"
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "http_port" {
  description = "The port for HTTP traffic"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "The path for health checks"
  type        = string
  default     = "/"
}