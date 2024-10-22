resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc
    enable_dns_hostnames = true
    enable_dns_support = true
  
}

resource "aws_internet_gateway" "my-vpc-igw" {
    vpc_id = aws_vpc.my-vpc.id
  
}

resource "aws_subnet" "my-vpc-public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = Var.Az
    cidr_block = var.public
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "my-vpc-private" {
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = var.Az
    cidr_block = var.private
  
}

resource "aws_route_table" "my-vpc-public-route" {
    vpc_id = aws_vpc.my-vpc.id
    route{
        cidr_block = var.route
        gateway_id = aws_internet_gateway.my-vpc-igw.id
    }
  
}

resource "aws_route_table_association" "my-vpc-public-rtba" {
    route_table_id = aws_route_table.my-vpc-public-route.id
    subnet_id = aws_subnet.my-vpc-public-subnet.id
  
}

resource "aws_eip" "my-vpc-eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "my-vpc-nat" {
    allocation_id = aws_eip.my-vpc-eip.id
    subnet_id = aws_subnet.my-vpc-public-subnet.id

  
}

resource "aws_route_table" "my-vpc-private-route" {
    vpc_id = aws_vpc.my-vpc.id
    route{
        cidr_block = var.route
        nat_gateway_id = aws_nat_gateway.my-vpc-nat.id

    }
  
}

resource "aws_route_table_association" "my-vpc-private-rtba" {
    subnet_id = aws_subnet.my-vpc-private.id
    route_table_id = aws_route_table.my-vpc-private-route.id
  
}