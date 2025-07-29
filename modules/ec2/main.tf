resource "aws_instance" "tomcat" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = [aws_security_group.tomcat_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y tomcat
              systemctl start tomcat
              systemctl enable tomcat
              EOF

  tags = {
    Name = "Tomcat-Instance-${count.index + 1}"
  }
}

resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat_sg"
  description = "Allow traffic for Tomcat instances"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "tomcat_efs" {
  creation_token = "tomcat-efs"
  performance_mode = "generalPurpose"
}

resource "aws_efs_mount_target" "tomcat_mount" {
  count          = var.instance_count
  file_system_id = aws_efs_file_system.tomcat_efs.id
  subnet_id      = var.subnet_id[count.index]
}

output "instance_ids" {
  value = aws_instance.tomcat[*].id
}

output "public_ips" {
  value = aws_instance.tomcat[*].public_ip
}