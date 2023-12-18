resource "aws_vpc" "vpc-server-preprod" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

#Adding the first subnet
resource "aws_subnet" "private-subnet-preprod-1" {
  vpc_id            = aws_vpc.vpc-server-preprod.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

#Adding the second subnet
resource "aws_subnet" "private-subnet-preprod-2" {
    vpc_id            = aws_vpc.vpc-server-preprod.id
    cidr_block        = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
    Name = "${var.env_prefix}-subnet-2"
    }

}

#Adding the third subnet
resource "aws_subnet" "public-subnet-preprod-1" {
    vpc_id            = aws_vpc.vpc-server-preprod.id
    cidr_block        = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
    Name = "${var.env_prefix}-subnet-3"
    }

}

resource "aws_internet_gateway" "int-gateway-preprod" {
  vpc_id = aws_vpc.vpc-server-preprod.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtbl-preprod" {
  default_route_table_id = aws_vpc.vpc-server-preprod.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int-gateway-preprod.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rtbl-preprod"
  }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.vpc-server-preprod.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.3.0.0/32"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}
