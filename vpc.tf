resource "aws_vpc" "pica" {
  cidr_block           = "10.0.0.0/16" # Cambia la CIDR según tus necesidades
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "pica-vpc"
  }
}

resource "aws_subnet" "pica_subnet_private" {
  vpc_id                  = aws_vpc.pica.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "pica-subnet-private"



  }
}

resource "aws_subnet" "pica_public" {
  vpc_id                  = aws_vpc.pica.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pica_public"
  }
}


resource "aws_internet_gateway" "pica_igw" {
  vpc_id = aws_vpc.pica.id
  tags = {
    Name = "pica-igw"
  }
}

resource "aws_route_table" "pica_table_route" {
  vpc_id = aws_vpc.pica.id
}

resource "aws_route" "pica_internet_gateway_route" {
  route_table_id         = aws_route_table.pica_table_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pica_igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.pica_public.id
  route_table_id = aws_route_table.pica_table_route.id
}

resource "aws_instance" "pica_instance_ec2" {
  ami               = "ami-05c13eab67c5d8861"
  availability_zone = "us-east-1a"
  instance_type     = "t2.micro"

  tags = {
    Name = "pica-intance"
  }
}

resource "aws_eip" "pica_eip" {
  instance = aws_instance.pica_instance_ec2.id
  domain   = "vpc"
}


resource "aws_route_table" "pica_private_route_table" {
  vpc_id = aws_vpc.pica.id
}



resource "aws_route_table_association" "pica_private_subnet_association" {
  subnet_id      = aws_subnet.pica_subnet_private.id
  route_table_id = aws_route_table.pica_private_route_table.id
}