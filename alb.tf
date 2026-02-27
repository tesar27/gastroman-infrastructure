resource "aws_lb" "app_alb" {
  name               = "gastroman-alb-${terraform.workspace}"
  load_balancer_type = "application"
  subnets            = [aws_subnet.gastroman_public_subnet_1.id, aws_subnet.gastroman_public_subnet_2.id]
  security_groups    = [aws_security_group.webserver_sg.id]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "gastroman-tg-${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.gastroman_vpc.id
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.gastroman_web_server.id
  port             = 80
}

resource "aws_lb_listener" "http_80" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
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

resource "aws_lb_listener" "https_443" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.app_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
