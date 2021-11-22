provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id = "subnet-0e6a2c0827160332c"
  ami = "ami-04526d8a7e0b5fb27"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "chave-key-erika"
  vpc_security_group_ids = ["${aws_security_group.exerc_java.id}"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-erika-tf-java"
  }
}

resource "aws_security_group" "exerc_java" {
  name        = "exerc_java"
  description = "acessos inbound traffic"
  vpc_id      = "vpc-010ad4cd4b8ad8a3c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}



# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 
