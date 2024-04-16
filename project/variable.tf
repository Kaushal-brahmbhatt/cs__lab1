variable "vault_addr" {
  type = string
  description = "Address of the HashiCorp Vault instance"
}

variable "vault_token" {
  type = string
  description = "Vault token with permission to access the AWS secrets engine"
}

variable "s3_bucket_name" {
  type = string
  description = "Name of the S3 bucket to create"
}
