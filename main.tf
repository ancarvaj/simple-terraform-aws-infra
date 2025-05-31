resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.cidr_subnet1
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "name" {
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    
}

resource "aws_route_table_association" "rt_association" {
  route_table_id = aws_route_table.name.id
  subnet_id = aws_subnet.public.id
}