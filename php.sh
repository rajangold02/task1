#!/bin/sh

sudo yum update -y
sudo yum install httpd -y
sudo yum install php -y
sudo service httpd start
cd /var/www/html
cat > index.php <<- "EOF"
<?php
echo "Hello World";
?>
EOF
sudo service httpd restart