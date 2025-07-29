variable "instance_type" {
  description = "The type of EC2 instance to use for Tomcat"
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0"  # Example AMI ID, replace with a valid one
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "user_data" {
  description = "User data script to install Tomcat"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y tomcat
                systemctl start tomcat
                systemctl enable tomcat
                EOF
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances"
  type        = number
  default     = 2
}