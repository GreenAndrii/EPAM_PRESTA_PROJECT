#!/bin/bash
echo "*************************** START SETUP Prestashop ***************************"
cd /var/www/html/

echo "Install Prestashop"
sudo php install/index_cli.php  --domain=$APACHE_DNS --db_user=prestashop --db_password=$DB_PASSWD --theme=$THEME_NAME

echo "Change access rights"
sudo chmod -R 755 .
sudo chown -R www-data:www-data  /var/www/html/

echo "Delete install folder"
sudo rm -rf install/

echo "Rename admin folder"
sudo mv admin admin_p

echo "************************** FINISH SETUP Prestashop *****************************"
