terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "vault" { 
  address = "http://127.0.0.1:8200" 
  skip_child_token = true 
  auth_login { 
    path = "auth/approle/login" 
    parameters = { 
        role_id   = var.vault_role_id
        secret_id = var.vault_secret_id 
      } 
    } 
  }
