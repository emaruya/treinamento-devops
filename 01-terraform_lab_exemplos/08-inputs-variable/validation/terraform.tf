terraform {
  backend "remote" {
    organization = "em_corp"

    workspaces {
      name = "workspace-em"
    }
  }
}
