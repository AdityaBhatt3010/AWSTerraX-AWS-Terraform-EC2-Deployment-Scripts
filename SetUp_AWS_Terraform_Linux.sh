# Install AWS CLI (Linux)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify AWS CLI installation
aws --version

# Set AWS credentials (replace XXXXXX with actual credentials)
export AWS_ACCESS_KEY_ID=XXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXX

# Create and navigate to Terraform project directory
mkdir learn-terraform-aws-instance
cd learn-terraform-aws-instance

# Create Terraform configuration file (main.tf)
touch main.tf

# Initialize Terraform project
terraform init

# Format and validate Terraform configuration
terraform fmt
terraform validate

# Apply Terraform configuration to provision resources
terraform apply -auto-approve

# Destroy infrastructure when no longer needed
# terraform destroy -auto-approve

