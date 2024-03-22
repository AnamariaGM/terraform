# Resource block for creating the VPC
resource "aws_vpc" "project_vpc" {
  cidr_block           = "10.0.0.0/20"  # CIDR block for the VPC
  enable_dns_hostnames = true           # Enable DNS hostnames for the VPC

  tags = {
    Name = "project_vpc"  # Tag for identifying the VPC
  }
}

# Resource block for creating public subnets
resource "aws_subnet" "public" {
  count = 3

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = "10.0.${count.index + 1}.0/24"  # CIDR block for public subnets
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet${count.index}"  # Tag for identifying public subnets
  }
}

# Resource block for creating private subnets
resource "aws_subnet" "private" {
  count = 3

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = "10.0.${count.index + 4}.0/24"  # CIDR block for private subnets

  tags = {
    Name = "private_subnet${count.index}"  # Tag for identifying private subnets
  }
}

# Resource block for creating an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project_vpc.id  # Attach internet gateway to the VPC

  tags = {
    Name = "project_igw"  # Tag for identifying the internet gateway
  }
}

# Resource block for creating a public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project_vpc.id  # Attach route table to the VPC

  # Define a route to route all traffic to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"  # Tag for identifying the route table
  }
}

# Resource block for creating a local route table
resource "aws_route_table" "local" {
  vpc_id = aws_vpc.project_vpc.id  # Attach route table to the VPC

  # Define a local route for VPC communication
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "local_rt"  # Tag for identifying the route table
  }
}

# Resource block for associating public subnets with the public route table
resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public[*])
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}
