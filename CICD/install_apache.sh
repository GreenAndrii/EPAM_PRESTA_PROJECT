#!/bin/bash
echo "********************************** START PREPARE ENVIRONMENT *******************************"
sudo apt-get update
echo "Install requirements..."
sudo apt-get -y install apache2 mysql-server php libapache2-mod-php php-xml php-gd php-mysql php-mbstring php-zip php-curl php-intl unzip jq

echo "Set rewrite mode ON"
sudo a2enmod rewrite

echo "Create Database for Prestashop"
sudo mysql -uroot -e "DROP DATABASE IF EXISTS prestashop; CREATE DATABASE prestashop; CREATE USER IF NOT EXISTS prestashop@localhost IDENTIFIED BY '$DB_PASSWD'; GRANT ALL PRIVILEGES on prestashop.* to prestashop@localhost IDENTIFIED BY '$DB_PASSWD'; FLUSH PRIVILEGES;"

echo "Restart services Apache and MySQL"
sudo systemctl restart apache2.service
sudo systemctl restart mysql.service

echo "Download Prestashop files"
cd /var/www/html/
sudo rm -rf ./*
sudo rm -f .htaccess
sudo wget -q https://download.prestashop.com/download/releases/prestashop_$PS_VERSION.zip

sudo unzip -o prestashop_$PS_VERSION.zip
sudo unzip -oq prestashop.zip 
sudo rm -f prestashop*.zip
sudo chown -R ubuntu:ubuntu  /var/www/html/
echo "********************************** FINISH PREPARE ENVIRONMENT *******************************"
