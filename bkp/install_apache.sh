#!/bin/bash
yum update
yum install httpd -y
service httpd start
chkconfig htpd on
echo "<h1> Deployed by Terraform-AWS Infra </h1>" > /var/www/html/index.html
