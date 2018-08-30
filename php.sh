#!/bin/sh

sudo yum update -y
sudo yum install httpd -y
sudo yum install php -y
sudo service httpd start
cd /var/www/html
sudo echo "<?php echo "Hello World!"; ?>" >index.php
sudo service httpd restart