#!/bin/bash
sudo apt-get update
#sudo curl -fsSL get.docker.com | sh -
#delete previous containers
docker rm -f $(docker ps -q)
export THEME_NAME=$(jq -r '.THEME_NAME' version.json)

echo "run docker container with prestashop"
cd CICD
docker-compose up -d

echo "Wait finishing install script..."
while [ -z "$(ps -e | grep apache2)" ]; do sleep 10; done
echo "Install script finished..."
# copy theme to volume
cd ~
sudo cp -r themes/$THEME_NAME /var/lib/docker/volumes/theme_data/_data
sudo chown -R www-data:www-data /var/lib/docker/volumes/theme_data/_data/$THEME_NAME


docker exec prestashop bash -c 'rm -rf install; mv admin admin_p'
