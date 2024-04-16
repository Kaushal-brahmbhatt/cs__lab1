resource "vault_aws_secret_backend" "aws" {
  path = "aws"
}

data "vault_secret" "read_only_s3_role" {
  path = "aws/roles/read-only-s3-role"
}

data "jsondecode" "s3_credentials" {
  data = base64decode(data.vault_secret.read_only_s3_role.value.access_key_id)
}

variable "aws_access_key_id" {
  type = string
  default = data.jsondecode.s3_credentials.access_key_id
}

variable "aws_secret_access_key" {
  type = string
  default = data.jsondecode.s3_credentials.secret_access_key
}

resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_iam_user" "s3_access_user" {
  name = "s3-access-user"

  access_key {
    user_name = aws_iam_user.s3_access_user.name
    access_key_id = var.aws_access_key_id
    secret_access_key = var.aws_secret_access_key
  }
}

resource "aws_iam_user_policy" "read_only_s3_policy" {
  name = "read-only-s3-policy"

  user = aws_iam_user.s3_access_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Resource": [
        arn:aws:s3:::${var.s3_bucket_name}
      ]
    }
  ]
}
EOF
}
