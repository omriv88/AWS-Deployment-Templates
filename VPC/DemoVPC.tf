provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1c"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.20.0/24"
  availability_zone = "us-east-1c"
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "10.10.0.0/16"
    gateway_id = aws_vpc.main_vpc.id
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_network_acl" "example_acl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "example_acl"
  }
}

resource "aws_network_acl_rule" "inbound_rule" {
  network_acl_id = aws_network_acl.example_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "outbound_rule" {
  network_acl_id = aws_network_acl.example_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"  # All protocols
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_association" "acl_association" {
  network_acl_id = aws_network_acl.example_acl.id
  subnet_id      = aws_subnet.subnet1.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  transit_gateway_id = "paste-the-tgw-id"
  vpc_id             = aws_vpc.main_vpc.id 
  subnet_id          = aws_subnet.subnet1.id
}
