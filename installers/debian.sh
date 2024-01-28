#!/bin/bash

echo -e "Starting Debian installer Script..."

MYSQL_ROOT_PASSWORD=$1

#updating packages
echo -e "Updating package lists.."
sudo apt-get -y update

#install Ngnix
echo -e "Installing Ngnix server..."
sudo apt-get -y install nginx
sudo ufw allow 'Nginx Full'


#add ondrej PPA
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

#install Mysql server
echo -e "Installing PHP-FPM and Mysql extension for PHP..."
sudo apt-get -y install php7.4-fpm php-mysql
