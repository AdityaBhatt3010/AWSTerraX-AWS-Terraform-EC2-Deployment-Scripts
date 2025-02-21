# Terraform AWS Deployment

This repository contains Terraform scripts to deploy **Amazon Linux 2023** and **Windows Server 2019** instances on AWS.
The configuration ensures that the instances are **Free Tier Eligible** and properly configured with security groups, key pairs, and storage options.

---

## 🚀 **Setup and Usage**
### **1️⃣ Prerequisites**
Before running Terraform, ensure you have:
- An AWS account
- Terraform installed ([Download Here](https://developer.hashicorp.com/terraform/downloads))
- AWS CLI installed ([Download Here](https://aws.amazon.com/cli/))
- Configured AWS credentials using:
  ```bash
  aws configure
  ```

### **2️⃣ AWS CLI Installation**

Here’s how to **run the script** on each platform:  

---

#### **🟢 Linux** (`SetUp_AWS_Terraform_Linux.sh`)
1. **Give execute permissions to the script:**  
   ```bash
   chmod +x SetUp_AWS_Terraform_Linux.sh
   ```
2. **Run the script:**  
   ```bash
   ./SetUp_AWS_Terraform_Linux.sh
   ```

---

#### **🔵 Windows (PowerShell)** (`SetUp_AWS_Terraform_Windows.ps1`)
1. **Open PowerShell as Administrator**
   - Press `Win + X`, then click **PowerShell (Admin)** or **Windows Terminal (Admin)**.

2. **Allow script execution (only if needed):**  
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. **Run the script:**  
   ```powershell
   .\SetUp_AWS_Terraform_Windows.ps1
   ```

---


#### **🔴 macOS** (`SetUp_AWS_Terraform_macOS.sh`)
1. **Give execute permissions to the script:**  
   ```bash
   chmod +x SetUp_AWS_Terraform_macOS.sh
   ```
2. **Run the script:**  
   ```bash
   ./SetUp_AWS_Terraform_macOS.sh
   ```

---

This will execute the **Terraform setup and AWS CLI installation** based on the OS. 🚀

## 💻 **AMIs Created**

### **🔹 Amazon Linux 2023 (Free Tier Eligible)**
- **Architecture:** 64-bit (x86)
- **Instance Type:** `t2.micro`
- **Storage:** 8 GiB gp3 (3000 IOPS, not encrypted)
- **Security Group:** Allows SSH (22), HTTP (80), and HTTPS (443)
- **Key Pair:** Created and saved as `KeyPair.pem`

### **🔹 Windows Server 2019 Base (Free Tier Eligible)**
- **Architecture:** 64-bit (x86)
- **Instance Type:** `t2.micro`
- **Storage:** 30 GiB gp3 (3000 IOPS, not encrypted)
- **Security Group:** Allows RDP (3389), HTTP (80), and HTTPS (443)
- **Key Pair:** Created and saved as `KeyPair.ppk`

---

## 🛠 **Terraform Commands**

### **1️⃣ Initialize Terraform**
```bash
terraform init
```

### **2️⃣ Format & Validate Configuration**
```bash
terraform fmt
terraform validate
```

### **3️⃣ Deploy AWS Infrastructure**
```bash
terraform apply -auto-approve
```

### **4️⃣ Destroy AWS Infrastructure**
```bash
terraform destroy -auto-approve
```

---

## 💡 **Notes**
- Use **PuTTYGen** to convert `.pem` to `.ppk` for Windows RDP:
  ```bash
  puttygen KeyPair.pem -o KeyPair.ppk
  ```
- Always check **Free Tier limits** to avoid unexpected charges.
- To manually delete resources, remove them from **AWS Console**.

---
