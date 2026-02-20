resource "aws_internet_gateway" "gastroman_igw" {
  vpc_id = aws_vpc.gastroman_vpc.id

  tags = {
    Name        = "gastroman-igw"
    Environment = local.environment
  }
}
