variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "cs-kaushal"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "ubuntu_ami" {
  default = "ami-07d9b9ddc6cd8dd30" 
}

variable "vault_role_id" {
  default = "87b136ad-e9e2-8d87-9083-f594909095d3"
} 

variable "vault_secret_id" {
  default = "f6e82bd1-7711-74ec-9848-44c5595a0f8a"
}