resource "aws_lb" "tomcat_lb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tomcat_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tomcat_tg.arn
  }
}

resource "aws_lb_target_group" "tomcat_tg" {
  name     = "${var.load_balancer_name}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "tomcat_attachment" {
  count              = var.ec2_instance_count
  target_group_arn   = aws_lb_target_group.tomcat_tg.arn
  target_id          = aws_instance.tomcat_ec2[count.index].id
  port               = 8080
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.load_balancer_name}-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}