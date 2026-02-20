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
