# AWS Load Balancer - SG
resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-${var.module}-${var.environment}-alb"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.common_tags
}

# Load Balancer
resource "aws_lb" "alb" {
  name                       = "${var.project}-${var.module}-${var.environment}-alb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [aws_security_group.alb_sg.id]
  ip_address_type            = "ipv4"
  subnets                    = toset(var.subnet_public_ids)
  preserve_host_header       = true
  enable_deletion_protection = false
  access_logs {
    bucket  = var.s3_access_log
    enabled = true
  }
  tags = local.common_tags
}

# Load Balancer: HTTP Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Load Balancer: HTTPS Listener
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Nothing."
      status_code  = "200"
    }
  }
}