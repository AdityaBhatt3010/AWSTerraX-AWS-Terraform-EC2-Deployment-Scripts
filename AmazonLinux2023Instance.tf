terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

# 🔑 Generate a new SSH key pair and save locally
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployed_key" {
  key_name   = "KeyPair"
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.key_pair.private_key_pem
  filename = "KeyPair.pem"
}

# 🔒 Security Group allowing SSH, HTTP, and HTTPS
resource "aws_security_group" "web_sg" {
  name        = "allow_web_traffic"
  description = "Allow SSH, HTTP, and HTTPS access"

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🖥️ EC2 Instance with Amazon Linux 2023
resource "aws_instance" "linux_server" {
  ami           = "ami-0cf10cdf9fcd62d37" # Amazon Linux 2023 AMI (x86_64) for us-east-2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployed_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  root_block_device {
    volume_size           = 8   # 8 GiB storage
    volume_type           = "gp3"
    iops                 = 3000 # IOPS for gp3
    encrypted            = false
  }

  tags = {
    Name = "AmazonLinux2023Instance"
  }
}
