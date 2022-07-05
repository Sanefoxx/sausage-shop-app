#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
#Очищаем директорию от старых версий фронтенда
sudo rm -rf sausage-store-[0-9,.]*
#Переносим артефакт в нужную папку
curl -u "$NEXUS_REPO_USER:$NEXUS_REPO_PASS" -o sausage-store.tar.gz ${NEXUS_REPO_URL}sausage-store-front/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
tar xvf sausage-store.tar.gz
sudo cp -rf sausage-store-$VERSION/public_html/* /var/www-data/dist/frontend||true #"jar||true" говорит, если команда обвалится — продолжай
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend.service