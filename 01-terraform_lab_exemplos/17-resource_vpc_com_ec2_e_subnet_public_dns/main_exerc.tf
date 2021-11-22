provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "erika-dev-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.sec-group-erika-tf}",
  ]
  tags = {
    Name = "ec2-erika-tf"
  }
}

resource "aws_instance" "web2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "erika-dev-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet2.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.sec-group-erika-tf}",
  ]
  tags = {
    Name = "ec2-erika-tf2"
  }
}

resource "aws_instance" "web3" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "erika-dev-keypair" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet3.id # vincula a subnet direto e gera o IP automático
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.sec-group-erika-tf}",
  ]
  tags = {
    Name = "ec2-erika-tf3"
  }
}

resource "aws_eip" "example" {
  vpc = true
}

# terraform refresh para mostrar o ssh

output "aws_instance_e_ssh" {
  value = [
    aws_instance.web.public_ip,
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web.public_dns}"
  ]
}