resource "aws_iam_role" "cs_ec2_role" {
  name = "cs_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cs_ec2_policy" {
  name        = "cs_ec2_policy"
  description = "Allow EC2 to access S3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::${var.bucket_name}", "arn:aws:s3:::${var.bucket_name}/*"]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "cs_ec2_policy_attachment" {
  role       = aws_iam_role.cs_ec2_role.name
  policy_arn = aws_iam_policy.cs_ec2_policy.arn
}

resource "aws_iam_instance_profile" "cs_ec2_instance_profile" {
  name = "cs_ec2_instance_profile"
  role = aws_iam_role.cs_ec2_role.name
}

resource "aws_s3_bucket" "cs_bucket" {
  bucket = var.bucket_name
  tags = {
    Env = "cs"
  }
}

resource "aws_key_pair" "cs_key" {
  key_name   = "cs-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "cs_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "cs_subnet" {
  vpc_id     = aws_vpc.cs_vpc.id
  cidr_block = var.subnet_cidr
}

resource "aws_security_group" "cs_sg" {
  name        = "cs-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.cs_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "cs_instance" {
  ami                  = var.ubuntu_ami
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.cs_key.key_name
  subnet_id            = aws_subnet.cs_subnet.id
    iam_instance_profile = aws_iam_instance_profile.cs_ec2_instance_profile.name
  tags = {
    Name = "cs-instance"
  }
}