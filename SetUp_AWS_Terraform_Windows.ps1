# PowerShell Script to Install and Configure AWS CLI on Windows

# Check if AWS CLI is installed
if (-Not (Get-Command aws -ErrorAction SilentlyContinue)) 
    {
    Write-Output "AWS CLI not found. Installing..."
    
    # Download and install AWS CLI
    $installerUrl = "https://awscli.amazonaws.com/AWSCLIV2.msi"
    $installerPath = "$env:TEMP\AWSCLIV2.msi"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
    
    if (-Not (Test-Path $installerPath)) 
    {
        Write-Output "Failed to download AWS CLI. Check your internet connection."
        exit 1
    }
    
    Start-Process msiexec.exe -ArgumentList "/i $installerPath /quiet /norestart" -Wait
    
    if (-Not (Get-Command aws -ErrorAction SilentlyContinue)) 
    {
        Write-Output "Failed to install AWS CLI. Please check for errors."
        exit 1
    }
    
    Write-Output "AWS CLI installed successfully."
} 
else 
{
    Write-Output "AWS CLI is already installed."
}

# Display AWS CLI version
aws --version

# Prompt user for AWS credentials
$AWS_ACCESS_KEY_ID = Read-Host "Enter your AWS Access Key ID"
$AWS_SECRET_ACCESS_KEY = Read-Host "Enter your AWS Secret Access Key" -AsSecureString
$AWS_REGION = Read-Host "Enter your AWS Region (e.g., us-east-1)"

Write-Output "Configuring AWS CLI..."

# Configure AWS CLI
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key (New-Object PSCredential "user", $AWS_SECRET_ACCESS_KEY).GetNetworkCredential().Password
aws configure set region $AWS_REGION

# Verify configuration
Write-Output "AWS CLI configured successfully. Verifying credentials..."
aws sts get-caller-identity

if ($?) 
{
    Write-Output "AWS CLI setup completed successfully!"
} 
else 
{
    Write-Output "Failed to configure AWS CLI. Please check your credentials and try again."
}

# Download and install Terraform
Invoke-WebRequest -Uri "https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_windows_amd64.zip" -OutFile "terraform.zip"
Expand-Archive -Path "terraform.zip" -DestinationPath "C:\Terraform" -Force
$env:Path += ";C:\Terraform"

# Create and navigate to Terraform project directory
New-Item -ItemType Directory -Path "AWS_Terraform_Trial" -Force
Set-Location "AWS_Terraform_Trial"

# Create a Terraform configuration file
New-Item -ItemType File -Path "main.tf" -Force

# Initialize Terraform project
terraform init

# Format and validate Terraform configuration
terraform fmt
terraform validate

# Apply Terraform configuration to provision AWS instance
terraform apply -auto-approve

# Destroy infrastructure when no longer needed
# terraform destroy -auto-approve
