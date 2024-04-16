provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = var.vault_addr
  token    = var.vault_token
}