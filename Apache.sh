#!/bin/bash

# Update package lists
sudo yum update -y  # Use sudo apt update -y for Ubuntu

# Install Apache Web Server
sudo yum install httpd -y  # Use sudo apt install apache2 -y for Ubuntu

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Create index.html with the desired content
echo "<h1>Welcome to My Apache Server</h1>" | sudo tee /var/www/html/index.html > /dev/null

# Adjust permissions (optional)
sudo chmod 644 /var/www/html/index.html
sudo chown apache:apache /var/www/html/index.html  # Use www-data:www-data for Ubuntu

# Restart Apache to apply changes
sudo systemctl restart httpd  # Use sudo systemctl restart apache2 for Ubuntu

# Print completion message
echo "Apache Web Server is installed and running. Access it via http://your-ec2-public-ip/"