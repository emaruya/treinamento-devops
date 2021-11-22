# variable "subnet_id" {
#   type        = string
#   description = "O id da subnet que será utilizada no servidor."

#   validation {
#     condition     = length(var.subnet_id) > 7 && substr(var.subnet_id, 0, 7) == "subnet-"
#     error_message = "O valor do subnet_id não é válido, é necessário começar com \"subnet-\"."
#   }
# }

# variable "image_id" {
#   type        = string
#   description = "O id do Amazon Machine Image (AMI) para ser usado no servidor."

#   validation {
#     condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
#     error_message = "O valor do image_id não é válido, é necessário começar com \"ami-\"."
#   }
# }

# variable "instance_type" {
#   type        = string
#   description = "O tipo da instância que será criada."

#   validation {
#     condition     = length(var.instance_type) > 3 && substr(var.instance_type, 0, 3) == "t2."
#     error_message = "O valor do instance_type não é válido, é necessário começar com \"t2.\"."
#   }
# }


provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  subnet_id = "subnet-0e6a2c0827160332c"
  ami = "ami-04526d8a7e0b5fb27"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "chave-key-erika"
  vpc_security_group_ids = ["sg-03c8100597f9f29f5"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-erika-tf-wordpress"
  }
}

resource "aws_key_pair" "chave-key-erika" {
  key_name   = "chave-key-erika"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/McqEFqxKLjqPsbkeAVE6HhlnA7bUgjIr/F+joVfudtkq6JrG+3JIvyWQ5BwhC3eaCQU9kRrZAtZx1ehqOODYTAX3nQ61Kk9s9eYQTRT/rSCx1Mj4wG+bBiiavI2h8xdeP+GDrp96Sy4Dyxq6yaPWSWw89DrCHm0/a4MwBP4Xf8v6u6K2V1OP5Np9e+h9/2OqVdVbZmS0U2BLJqy10ruCzoVWZcmI/+74rmW6lM/0lAD/boeA7KAYLC+xTcKhXT5jKU2rMV2lFepZ3pK3kIIQ6HF+MeRsgVBemKPymReucEPq513NjK9e9XVOrkZVak7wA1Pt1nK/WumaMHhFKU52OLdr3TyltyC3osuOtN1n8E2h3fWYTXRpXu/5EaegAMumZpHa+sq8B6pMxMqvq8WVdVJsKmz3Bgn0Q2phYy3Kk/vPZOiy0jXq8mV3dXYN2N8ykZu1COLz7r7W4Z+JA3DbxHp5yUnWLQYgvgidWMUmbFuj1IWK4iKHi+Z3g+sS4CE= ubuntu@erika-aws-dev"
}