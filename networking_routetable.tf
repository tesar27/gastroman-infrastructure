resource "aws_default_route_table" "gastroman_default_rt" {
  default_route_table_id = aws_vpc.gastroman_vpc.default_route_table_id

  tags = {
    Name        = "gastroman-default-rt"
    Environment = local.environment
  }
}

resource "aws_route_table" "gastroman_public_rt" {
  vpc_id = aws_vpc.gastroman_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gastroman_igw.id
  }
  tags = {
    Name        = "gastroman-public-rt"
    Environment = local.environment
  }
}

resource "aws_route_table_association" "gastroman_public_rt_assoc_1" {
  subnet_id      = aws_subnet.gastroman_public_subnet_1.id
  route_table_id = aws_route_table.gastroman_public_rt.id
}

resource "aws_route_table_association" "gastroman_public_rt_assoc_2" {
  subnet_id      = aws_subnet.gastroman_public_subnet_2.id
  route_table_id = aws_route_table.gastroman_public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.gastroman_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "gastroman-private-rt-${terraform.workspace}"
    Environment = terraform.workspace
  }
}

resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id      = aws_subnet.gastroman_private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id      = aws_subnet.gastroman_private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}
