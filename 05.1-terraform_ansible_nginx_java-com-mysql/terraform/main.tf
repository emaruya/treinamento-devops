provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id = "subnet-0e6a2c0827160332c"
  ami = "ami-04526d8a7e0b5fb27"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  key_name = "chave-key-erika"
  vpc_security_group_ids = ["${aws_security_group.acessos.id}"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-erika-tf-java2"
  }
}

resource "aws_security_group" "acessos" {
  name        = "acessos nginx java mysql"
  description = "acessos nginx java mysql inbound traffic"
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
    Name = "acessos nginx java mysql"
  }
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    "PUBLIC_DNS=${aws_instance.web.public_dns}",
    "PUBLIC_IP=${aws_instance.web.public_ip}",
    "ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@${aws_instance.web.public_dns} -o StrictHostKeyChecking=no"
  ]
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 
