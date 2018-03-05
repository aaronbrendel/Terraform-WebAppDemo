#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#Update packages and Upgrade system
echo "Updating System"
sudo apt-get -y update && sudo apt-get -y upgrade

echo "Installing Apache2"
sudo apt-get -y install apache2 --allow-unauthenticated

#Finding Public IP of Server
PUB_IP="$(ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' | head -1)"

#Editing apache2.conf file
egrep -q "$PUB_IP" /etc/apache2/apache2.conf || echo "ServerName $PUB_IP" >> /etc/apache2/apache2.conf

#Installing PHP and required modules
echo "Installing php modules"
echo "deb http://ftp.de.debian.org/debian stretch main" >> /etc/apt/sources.list
apt-get -y install php7.0 php7.0-mysql libapache2-mod-php7.0

#Setting permissions and ownership for /var/www
echo "Setting ownership on /var/www"
sudo chown -R www-data:www-data /var/www

#Downloading demo.php file
wget https://raw.githubusercontent.com/STVIN/azure-Getting-Started-with-Terraform/master/scripts/demo.php -O /var/www/html/demo.php
sudo chown -R www-data:www-data /var/www/html/demo.php

a2enconf php7.0-fpm
a2enmod php7.0
systemctl restart apache2

printf "192.168.1.4\tubuntuweb\n" >> /etc/hosts
printf "192.168.2.5\tubuntudb\n" >> /etc/hosts
