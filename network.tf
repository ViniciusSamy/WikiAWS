resource "aws_vpc" "main" {
  cidr_block = var.cidr["vpc"]
  tags = {
    Name = "${var.network_prefix}-vpc"
  }
}


resource "aws_subnet" "public" {
  count                   = length(var.available_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr["public_subnets"], 8, count.index)
  availability_zone       = "${var.region}${var.available_zones[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.network_prefix}-public-${var.available_zones[count.index]}"
  }
}


resource "aws_subnet" "private" {
  count             = length(var.available_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr["private_subnets"], 8, count.index + 127)
  availability_zone = "${var.region}${var.available_zones[count.index]}"

  tags = {
    Name = "${var.network_prefix}-private-${var.available_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.network_prefix}-igw"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.network_prefix}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "${var.network_prefix}-private-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}