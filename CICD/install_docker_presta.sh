#!/bin/bash
sudo apt-get update
#sudo curl -fsSL get.docker.com | sh -
#delete previous containers
docker rm -f presta-mysql prestashop

echo "run docker container with prestashop"
docker-compose up -d -f CICD/docker-compose.yml


# copy theme to volume
sudo cp -r themes/$THEME_NAME /var/lib/docker/volumes/theme_data/_data/var/www/html/themes/$THEME_NAME
sudo chown -R www-data:www-data /var/lib/docker/volumes/theme_data/_data/var/www/html/themes/$THEME_NAME

echo "Wait finishing install script..."
while [ -z "$(ps -e | grep apache2)" ]; do sleep 10; done
echo "Install script finished..."
cd /var/lib/docker/volumes/theme_data/_data/var/www/html
sudo rm -rf install
sudo mv admin admin_p
