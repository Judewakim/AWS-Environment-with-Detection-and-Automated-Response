# #!/bin/bash
# yum update -y
# yum install -y httpd
# systemctl enable httpd
# systemctl start httpd

# echo "<html><h1>Welcome to My Web Server!</h1></html>" > /var/www/html/index.html

#-------------------------------------------------------------------------

#!/bin/bash

# Log start (DOESNT WORK)
# exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update packages
sudo yum update -y

# Install Apache
sudo yum install -y httpd

# Enable and start Apache
sudo systemctl enable httpd
sudo systemctl start httpd

# Add basic webpage
sudo tee /var/www/html/index.html > /dev/null <<EOF
<html>
  <head><title>Web Server</title></head>
  <body>
    <h1>Hello from your secure AWS Web Server!</h1>
    <p>Deployed using Terraform and configured with user data.</p>
  </body>
</html>
EOF

# Log completion
echo "Web server setup complete at $(date)" | sudo tee -a /var/log/user_data.log > /dev/null

