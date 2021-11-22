terraform {
  required_version = ">= 0.12" # colocando compatibilidade do terraform para 0.12
}

resource "aws_security_group" "erika-secgroup-module" {
  name        = "erika-secgroup-module"
  description = "Allow SSH and custom TCP inbound traffic"
  vpc_id      = "vpc-010ad4cd4b8ad8a3c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      description: "Libera dados da rede interna"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "erika-secgroup-module"
  }
}

resource "aws_instance" "web" {
  subnet_id     = "subnet-07384d1338e0f2f61"
  instance_type = "t2.micro"
  ami = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  vpc_security_group_ids  = [
    "${aws_security_group.erika-secgroup-module}",
  ]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}"
  }
}