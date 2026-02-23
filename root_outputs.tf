output "webserver_public_ip" {
  description = "Public IP of Web Server"
  value       = aws_instance.gastroman_web_server.public_ip
}

output "webserver_dns_name" {
  description = "DNS name of Web Server"
  value       = aws_instance.gastroman_web_server.public_dns
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.gastroman_vpc.id
}

# output "mariadb_endpoint" {
#   description = "MariaDB endpoint"
#   value       = aws_db_instance.mariadb.endpoint
# }

# output "mariadb_db_name" {
#   description = "MariaDB database name"
#   value       = aws_db_instance.mariadb.db_name
# }

# output "mariadb_port" {
#   description = "MariaDB port"
#   value       = aws_db_instance.mariadb.port
# }
