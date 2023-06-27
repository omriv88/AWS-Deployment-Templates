# Subnet 1 
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet2"
  }
}

# Subnet 3
resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet3"
  }
}

# Subnet 4
resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet4"
  }
}

# Subnet 5 
resource "aws_subnet" "subnet5" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet5"
  }
}

# Subnet 6 
resource "aws_subnet" "subnet6" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.6.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet6"
  }
}

# Subnet 7
resource "aws_subnet" "subnet7" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.7.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet7"
  }
}

# Subnet 8
resource "aws_subnet" "subnet8" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.8.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet8"
  }
}

# Subnet 9 
resource "aws_subnet" "subnet9" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.9.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet9"
  }
}

# Subnet 10
resource "aws_subnet" "subnet10" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-west-1a"
}

# Subnet 11
resource "aws_subnet" "subnet11" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.11.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet11"
  }
}

# Subnet 12
resource "aws_subnet" "subnet12" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.10.12.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "subnet12"
  }
}

# Subnet Associations
resource "aws_subnet_network_acl_association" "subnet_association1" {
  subnet_id      = aws_subnet.subnet1.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association2" {
  subnet_id      = aws_subnet.subnet2.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association3" {
  subnet_id      = aws_subnet.subnet3.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association4" {
  subnet_id      = aws_subnet.subnet4.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association5" {
  subnet_id      = aws_subnet.subnet5.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association6" {
  subnet_id      = aws_subnet.subnet6.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association7" {
  subnet_id      = aws_subnet.subnet7.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association8" {
  subnet_id      = aws_subnet.subnet8.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association9" {
  subnet_id      = aws_subnet.subnet9.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association10" {
  subnet_id      = aws_subnet.subnet10.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association11" {
  subnet_id      = aws_subnet.subnet11.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_subnet_network_acl_association" "subnet_association12" {
  subnet_id      = aws_subnet.subnet12.id
  network_acl_id = aws_network_acl.network_acl.id
}
