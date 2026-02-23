resource "aws_vpc" "gastroman_vpc" {
  cidr_block           = var.gastroman_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = "gastroman-vpc_${terraform.workspace}"
    env  = terraform.workspace
  }
}
