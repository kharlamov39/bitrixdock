#!/bin/sh
set -e

echo "Create folder struct"
mkdir -p /home/dev/www/bitrix && \
cd /home/dev/www && \
rm -f /home/dev/www/bitrix/bitrixsetup.php && \
curl -fsSL https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -o /home/dev/www/bitrix/bitrixsetup.php && \
rm -rf /home/dev/www/bitrixdock && \
git clone --depth=1 https://github.com/bitrixdock/bitrixdock.git && \
sudo chmod -R 777 /home/dev/www/bitrix && sudo chown -R root:www-data /home/dev/www/bitrix && \

echo "Config"
cp -f /home/dev/www/bitrixdock/.env_template /home/dev/www/bitrixdock/.env
sed -i 's/SITE_PATH=.\/www/SITE_PATH=\/home\/dev\/www\/bitrix/' /home/dev/www/bitrixdock/.env

echo "Run"
docker compose -p bitrixdock down
docker compose -f /home/dev/www/bitrixdock/docker-compose.yml -p bitrixdock up -d