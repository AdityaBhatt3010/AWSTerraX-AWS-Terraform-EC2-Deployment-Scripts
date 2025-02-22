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

resource "local_file" "private_key_pem" {
  content  = tls_private_key.key_pair.private_key_pem
  filename = "KeyPair.pem"
}

resource "null_resource" "convert_pem_to_ppk" {
  provisioner "local-exec" {
    command = "puttygen KeyPair.pem -o KeyPair.ppk"
  }
  depends_on = [local_file.private_key_pem]
}

# 🔒 Security Group allowing RDP, HTTP, and HTTPS
resource "aws_security_group" "win_sg" {
  name        = "allow_windows_traffic"
  description = "Allow RDP, HTTP, and HTTPS access"

  ingress {
    description = "Allow RDP from anywhere"
    from_port   = 3389
    to_port     = 3389
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

# 🖥️ EC2 Instance with Microsoft Windows Server
resource "aws_instance" "windows_server" {
  ami           = "ami-0233214e13e500f77" # Windows Server 2019 Base AMI (Free Tier Eligible) for us-east-2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployed_key.key_name
  vpc_security_group_ids = [aws_security_group.win_sg.id]

  root_block_device {
    volume_size = 30  # 30 GiB storage
    volume_type = "gp3"
    iops        = 3000 # IOPS for gp3
    encrypted   = false
  }

  user_data = <<-EOF
  <powershell>
  # Install IIS (Internet Information Services) Web Server
  Install-WindowsFeature -name Web-Server -IncludeManagementTools

  # Create an index.html file in the IIS web root directory with custom content
  New-Item -Path C:\inetpub\wwwroot\index.html -ItemType File -Value "<h1>Welcome to My IIS Server</h1>" -Force
  
  # IIS automatically serves the index.html file from C:\inetpub\wwwroot\
  # You can access the page at http://localhost/ after IIS is installed
  </powershell>
  EOF

  tags = {
    Name = "WindowsServerInstance"
  }
}
