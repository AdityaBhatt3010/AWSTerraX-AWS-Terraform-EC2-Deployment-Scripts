# Step 1: Download and install AWS CLI for Windows
 Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
 Start-Process msiexec.exe -ArgumentList "/i AWSCLIV2.msi /quiet /norestart" -Wait

# Step 2: Verify AWS CLI installation
aws --version

# Step 3: Prompt user for AWS credentials
$AWS_ACCESS_KEY_ID = Read-Host "Enter your AWS Access Key ID"
$AWS_SECRET_ACCESS_KEY = Read-Host "Enter your AWS Secret Access Key" -AsSecureString
$AWS_SECRET_ACCESS_KEY_Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($AWS_SECRET_ACCESS_KEY)
)
$AWS_REGION = Read-Host "Enter your AWS Region"

# Step 4: Set AWS credentials
$env:AWS_ACCESS_KEY_ID = $AWS_ACCESS_KEY_ID
$env:AWS_SECRET_ACCESS_KEY = $AWS_SECRET_ACCESS_KEY
$env:AWS_REGION = $AWS_REGION

# Step 5: Download and install Terraform
Invoke-WebRequest -Uri "https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_windows_amd64.zip" -OutFile "terraform.zip"
Expand-Archive -Path "terraform.zip" -DestinationPath "C:\Terraform" -Force
$env:Path += ";C:\Terraform"

# Step 6: Create and navigate to Terraform project directory
New-Item -ItemType Directory -Path "learn-terraform-aws-instance" -Force
Set-Location "learn-terraform-aws-instance"

# Step 7: Create a Terraform configuration file
New-Item -ItemType File -Path "main.tf" -Force

# Step 8: Initialize Terraform project
terraform init

# Step 9: Format and validate Terraform configuration
terraform fmt
terraform validate

# Step 10: Apply Terraform configuration to provision AWS instance
terraform apply -auto-approve

# Step 11: Destroy infrastructure when no longer needed
# terraform destroy -auto-approve
