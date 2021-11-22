provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia" {
  source = "git@github.com:emaruya/erika-module.git"
  nome = "Um nome"
}
