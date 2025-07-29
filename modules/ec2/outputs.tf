resource "aws_instance" "tomcat_instances" {
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
    Name = "TomcatInstance-${count.index}"
  }
}

resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat_sg"
  description = "Allow traffic for Tomcat"

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

output "instance_ids" {
  value = aws_instance.tomcat_instances[*].id
}

output "public_ips" {
  value = aws_instance.tomcat_instances[*].public_ip
}