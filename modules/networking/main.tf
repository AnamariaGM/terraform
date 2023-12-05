resource "aws_vpc" "project_vpc" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_hostnames = true
  tags = {
    Name = "project_vpc"
  }
}

resource "aws_subnet" "public" {
  count = 3

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = "10.0.${count.index +1}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = 3

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = "10.0.${count.index + 4}.0/24"

  tags = {
    Name = "private_subnet${count.index}"
  }

}




resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project_vpc.id

    tags = {
    Name = "project_igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route_table" "local" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "local_rt"
  }

}


resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public[*])
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}