resource "aws_launch_template" "web_lt" {
  name_prefix   = "gastroman-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.gastroman_web_server_instance_type
  user_data     = filebase64("compute_userdata.sh")
}

resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.gastroman_private_subnet_1.id, aws_subnet.gastroman_private_subnet_2.id]
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
}
