variable "subnet_id" {
  type        = string
  description = "O id da subnet que será utilizada no servidor."

  validation {
    condition     = length(var.subnet_id) > 7 && substr(var.subnet_id, 0, 7) == "subnet-"
    error_message = "O valor do subnet_id não é válido, é necessário começar com \"subnet-\"."
  }
}

variable "image_id" {
  type        = string
  description = "O id do Amazon Machine Image (AMI) para ser usado no servidor."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "O valor do image_id não é válido, é necessário começar com \"ami-\"."
  }
}

variable "instance_type" {
  type        = string
  description = "O tipo da instância que será criada."

  validation {
    condition     = length(var.instance_type) > 3 && substr(var.instance_type, 0, 3) == "t2."
    error_message = "O valor do instance_type não é válido, é necessário começar com \"t2.\"."
  }
}

variable "sec_group" {
  type        = string
  description = "O grupo de segurança para controlar o tráfego."

  validation {
    condition     = length(var.sec_group) > 3 && substr(var.sec_group, 0, 3) == "sg-"
    error_message = "O valor do sec_group não é válido, é necessário começar com \"sg-\"."
  }
}

provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  subnet_id = var.subnet_id
  ami = var.image_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sec_group]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-erika-tf-variables"
  }
}

output "subnet_id" {
    value = var.subnet_id
}

output "image_id" {
    value = var.image_id
}

output "instance_type" {
    value = var.instance_type
}

output "sec_group" {
    value = var.sec_group
}