provider "aws" {
  region = "us-east-1" 
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Create ACL
resource "aws_network_acl" "example_acl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "example_acl"
  }
}
#  Create internet GW
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}
# Create routing table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_route_table"
  }
}


#Confiugre RT
resource "aws_route" "route1" {
  route_table_id         = aws_route_table.main_route_table.id
  destination_cidr_block = "10.10.0.0/16"
  gateway_id             = "local"
}

resource "aws_route" "route2" {
  route_table_id         = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id

}

# Create subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.20.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet2"
  }
}
resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.30.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet3"
  }
}


###########
resource "aws_main_route_table_association" "main_route_table_association" {
  vpc_id         = aws_vpc.main_vpc.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main_route_table.id
}

# Associate subnets with rt
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.main_route_table.id
}

# Inbound rule
resource "aws_network_acl_rule" "inbound_rule" {
  network_acl_id = aws_network_acl.example_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "all"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

# Outbound rule
resource "aws_network_acl_rule" "outbound_rule" {
  network_acl_id = aws_network_acl.example_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "all" 
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
