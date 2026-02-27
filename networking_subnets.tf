resource "aws_subnet" "gastroman_public_subnet_1" {
  vpc_id            = aws_vpc.gastroman_vpc.id
  cidr_block        = var.gastroman_public_subnet_1_cidr
  availability_zone = var.aws_availability_zone_a
  #map_public_ip_on_launch = true

  tags = {
    Name        = "gastroman-public-subnet-1"
    Environment = local.environment
  }
}

resource "aws_subnet" "gastroman_public_subnet_2" {
  vpc_id            = aws_vpc.gastroman_vpc.id
  cidr_block        = var.gastroman_public_subnet_2_cidr
  availability_zone = var.aws_availability_zone_b
  #map_public_ip_on_launch = true
  tags = {
    Name        = "gastroman-public-subnet-2"
    Environment = local.environment
  }
}

resource "aws_subnet" "gastroman_private_subnet_1" {
  vpc_id            = aws_vpc.gastroman_vpc.id
  cidr_block        = var.gastroman_private_subnet_1_cidr
  availability_zone = var.aws_availability_zone_a

  tags = {
    Name        = "gastroman-private-subnet-1"
    Environment = local.environment
  }
}

resource "aws_subnet" "gastroman_private_subnet_2" {
  vpc_id            = aws_vpc.gastroman_vpc.id
  cidr_block        = var.gastroman_private_subnet_2_cidr
  availability_zone = var.aws_availability_zone_b

  tags = {
    Name        = "gastroman-private-subnet-2"
    Environment = local.environment
  }
}
