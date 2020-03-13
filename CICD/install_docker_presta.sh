#!/bin/bash
sudo apt-get update
sudo curl -fsSL get.docker.com | sh -
#delete previous containers
docker rm -f presta-mysql prestashop

echo "run docker container with prestashop"
CICD/docker-compose up -d

echo "Wait finishing install script..."
while [ -z "$(ps -e | grep apache2)" ]; do sleep 10; done
echo "Install script finished..."
# copy theme to container's folder
docker cp themes prestashop:/var/www/html/
docker exec prestashop bash -c 'chown -R www-data:www-data /var/www/html/themes/shop_theme; rm -rf install; mv admin admin_p'
# activate new theme
docker exec presta-mysql mysql -uroot -p$DB_PASSWD -e "use prestashop; \
UPDATE ps_shop SET theme_name='shop_theme';"
