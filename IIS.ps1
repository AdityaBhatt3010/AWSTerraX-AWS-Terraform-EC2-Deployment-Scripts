# Install IIS (Internet Information Services) Web Server
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Create an index.html file in the IIS web root directory with custom content
New-Item -Path C:\inetpub\wwwroot\index.html -ItemType File -Value "<h1>Welcome to My IIS Server</h1>" -Force

# IIS automatically serves the index.html file from C:\inetpub\wwwroot\
# You can access the page at http://localhost/ after IIS is installed