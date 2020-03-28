#VPC Creation
resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "terraform_vpc"
  }
}

#Internet gateway and attach to VPC tf_vpc
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "terraform_IG"
  }
}

#Subnets - Build multiple subnets 
resource "aws_subnet" "tf_public" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.tf_vpc.id
  availability_zone       = element(var.azs, count.index)
  cidr_block              = element(var.subnets_cidr, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_subnet-${count.index + 1}"
  }
}

#Public Route tables and attah the Internet gateway associated with public subnet
resource "aws_route_table" "tf_public_route" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = {
    Name = "tf_PublicRT"
  }
}

#Attach Route table to Public Subnets 
resource "aws_route_table_association" "tf_rta" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.tf_public.*.id, count.index)
  route_table_id = aws_route_table.tf_public_route.id
}


