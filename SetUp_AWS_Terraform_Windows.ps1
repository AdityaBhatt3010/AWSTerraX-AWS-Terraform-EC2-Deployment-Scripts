# Step 1: Download and install AWS CLI for Windows
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
Start-Process msiexec.exe -ArgumentList "/i AWSCLIV2.msi /quiet /norestart" -Wait

# Step 2: Verify AWS CLI installation
aws --version

# Step 3: Set AWS credentials (Replace XXXXXX with actual credentials)
$env:AWS_ACCESS_KEY_ID="XXXXXX"
$env:AWS_SECRET_ACCESS_KEY="XXXXXXXXXX"

# Step 4: Create and navigate to Terraform project directory
New-Item -ItemType Directory -Path "learn-terraform-aws-instance"
Set-Location "learn-terraform-aws-instance"

# Step 5: Create a Terraform configuration file
New-Item -ItemType File -Path "main.tf"

# Step 6: Initialize Terraform project
terraform init

# Step 7: Format and validate Terraform configuration
terraform fmt
terraform validate

# Step 8: Apply Terraform configuration to provision AWS instance
terraform apply -auto-approve

# Step 9: Destroy infrastructure when no longer needed
# terraform destroy -auto-approve
