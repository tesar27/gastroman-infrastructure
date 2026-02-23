resource "aws_security_group" "webserver_sg" {
  name        = "gastroman-webserver-sg"
  description = "Security group for Gastroman webserver"
  vpc_id      = aws_vpc.gastroman_vpc.id

  tags = {
    Name        = "webserver-sg"
    Environment = local.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "webserver_sg_ingress_http" {
  security_group_id = aws_security_group.webserver_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "webserver_sg_egress_all" {
  security_group_id = aws_security_group.webserver_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "ssh_sg" {
  name        = "gastroman-ssh-sg"
  description = "Security group for Gastroman SSH access"
  vpc_id      = aws_vpc.gastroman_vpc.id

  tags = {
    Name        = "ssh-sg"
    Environment = local.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_sg_ingress_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.my_local_public_ip
}

resource "aws_vpc_security_group_egress_rule" "ssh_sg_egress_all" {
  security_group_id = aws_security_group.ssh_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
