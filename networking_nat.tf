resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.gastroman_public_subnet_1.id

  tags = {
    Name        = "gastroman-nat-gw-${terraform.workspace}"
    Environment = terraform.workspace
  }
}
