resource "aws_vpc" "my_vpc" {
  cidr_block = "10.100.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-erika-tf"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.100.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "subnet-erika-tf-1a"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.100.2.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "subnet-erika-tf-1b"
  }
}

resource "aws_subnet" "my_subnet3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.100.3.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "subnet-erika-tf-1c"
  }
}

resource "aws_subnet" "my_subnet4" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.100.4.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "subnet-erika-tf-priv"
  }
}

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "igwy-erika-tf"
#   }
# }

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      
  ]

  tags = {
    Name = "rt-erika-tf"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.my_subnet3.id
  route_table_id = aws_route_table.rt_terraform.id
}

# resource "aws_network_interface" "my_subnet" {
#   subnet_id           = aws_subnet.my_subnet.id
#   private_ips         = ["172.17.10.100"] # IP definido para instancia
#   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

#   tags = {
#     Name = "primary_network_interface my_subnet"
#   }
# }