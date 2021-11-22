provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id     = "subnet-07384d1338e0f2f61"
  ami           = "ami-04526d8a7e0b5fb27"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "erika-dev-keypair"
    root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids = ["${aws_security_group.secgroup-exerc-erika2.id}"]
  tags = {
    Name = "ec2-erika-tf-secgroup2"
  }

}