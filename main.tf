#Creating aws VPC resource

resource "aws_vpc" "base" {
  cidr_block = var.VPC_info.cidr_block
  tags = {
    Name = var.VPC_info.name
  }
}

#Creating aws Public subnet resource

resource "aws_subnet" "public" {
  count             = length(var.subnet_public)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.subnet_public[count.index].subnet_cidr_block
  availability_zone = var.subnet_public[count.index].subnet_availability_zone
  depends_on        = [aws_vpc.base]
  tags = {
    Name = var.subnet_public[count.index].name
  }
}

#Creating aws Private subnet resource

resource "aws_subnet" "private" {
  count             = length(var.subnet_private)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.subnet_private[count.index].subnet_cidr_block
  availability_zone = var.subnet_private[count.index].subnet_availability_zone
  depends_on        = [aws_vpc.base]
  tags = {
    Name = var.subnet_private[count.index].name
  }
}

#Creating aws Public route table resource 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  count  = length(var.subnet_public) > 0 ? 1 : 0
  tags = {
    Name = "Public_RT"
  }
}

#Creating aws Private route table resource

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id
  count  = length(var.subnet_private) > 0 ? 1 : 0
  tags = {
    Name = "Private_RT"
  }
}

#Creating aws Public route table association resource(Web1,Web2)

resource "aws_route_table_association" "public" {
  count          = length(var.subnet_public)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
  depends_on     = [aws_vpc.base, aws_subnet.public]
}

#Creating aws Private route table association resource(app1,app2,db1,db2)

resource "aws_route_table_association" "private" {
  count          = length(var.subnet_private)
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
  depends_on     = [aws_vpc.base, aws_subnet.private]
}

#Creating internet gateway resource

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Ntier-igw"
  }
}

# Creating for aws route table connecting for the network connections

resource "aws_route" "Public" {
  count                  = length(aws_route_table.public) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
  depends_on             = [aws_vpc.base]
}