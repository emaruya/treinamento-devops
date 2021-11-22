provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  subnet_id     = "subnet-07384d1338e0f2f61"
  ami= "ami-04526d8a7e0b5fb27"
  instance_type = "t2.micro"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-erika-terraform6"
  }
}

# https://www.terraform.io/docs/language/values/outputs.html
output "instance_ip_addr" {
  value = [
    aws_instance.web.private_ip, 
    aws_instance.web.public_ip,
    "ssh -i /Users/erikamaruya/.ssh/chave_privada.pem ubuntu@${aws_instance.web.public_ip}"
  ]
  description = "Mostra os IPs publicos e privados da maquina criada."
}