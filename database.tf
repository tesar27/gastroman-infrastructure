resource "aws_db_subnet_group" "gastroman_db_subnet_group" {
  name       = "gastroman-db-subnet-group-${terraform.workspace}"
  subnet_ids = [aws_subnet.gastroman_private_subnet_1.id, aws_subnet.gastroman_private_subnet_2.id]

  tags = {
    Name        = "gastroman-db-subnet-group"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "mariadb_sg" {
  name        = "gastroman-mariadb-sg-${terraform.workspace}"
  description = "Security group for Gastroman MariaDB"
  vpc_id      = aws_vpc.gastroman_vpc.id

  tags = {
    Name        = "mariadb-sg"
    Environment = terraform.workspace
  }
}

resource "aws_vpc_security_group_ingress_rule" "mariadb_sg_ingress_webserver" {
  security_group_id            = aws_security_group.mariadb_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_vpc_security_group_egress_rule" "mariadb_sg_egress_all" {
  security_group_id = aws_security_group.mariadb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_db_instance" "mariadb" {
  identifier = "gastroman-mariadb-${terraform.workspace}"

  engine         = "mariadb"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = 100
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_admin_username
  password = var.db_admin_password
  port     = 3306

  db_subnet_group_name   = aws_db_subnet_group.gastroman_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.mariadb_sg.id]
  publicly_accessible    = false
  multi_az               = var.db_multi_az

  backup_retention_period   = var.db_backup_retention_period
  skip_final_snapshot       = var.db_skip_final_snapshot
  final_snapshot_identifier = "gastroman-mariadb-${terraform.workspace}-final"
  deletion_protection       = var.db_deletion_protection

  auto_minor_version_upgrade = true
  apply_immediately          = true

  tags = {
    Name        = "gastroman-mariadb"
    Environment = terraform.workspace
  }
}
