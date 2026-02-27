resource "aws_instance" "gastroman_web_server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.gastroman_web_server_instance_type
  subnet_id                   = aws_subnet.gastroman_private_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id, aws_security_group.ssh_sg.id]
  key_name                    = var.key_pair_name
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = file("compute_userdata.sh")
  user_data_replace_on_change = terraform.workspace == "dev"
  tags = {
    Name        = "Gastroman Web Server"
    Environment = terraform.workspace
  }
}
