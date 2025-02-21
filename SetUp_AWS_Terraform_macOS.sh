#!/bin/bash

# Step 1: Install AWS CLI for macOS
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# Step 2: Verify AWS CLI installation
aws --version

# Step 3: Set AWS credentials (Replace XXXXXX with actual credentials)
export AWS_ACCESS_KEY_ID="XXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXXXXX"

# Step 4: Create and navigate to Terraform project directory
mkdir -p learn-terraform-aws-instance
cd learn-terraform-aws-instance

# Step 5: Create a Terraform configuration file
touch main.tf

# Step 6: Initialize Terraform project
terraform init

# Step 7: Format and validate Terraform configuration
terraform fmt
terraform validate

# Step 8: Apply Terraform configuration to provision AWS instance
terraform apply -auto-approve

# Step 9: Destroy infrastructure when no longer needed
# terraform destroy -auto-approve
