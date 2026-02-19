resource "aws_vpc" "booltstore_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "booltstore_vpc"
  }
}
