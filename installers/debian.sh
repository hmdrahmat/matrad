#!/bin/bash

echo -e "Starting Ubuntu installer Script..."

MYSQL_ROOT_PASSWORD=$1

#updating packages
echo -e "Updating package lists.."
sudo apt-get -y update
