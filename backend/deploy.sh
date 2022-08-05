#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Запишем креды в файл для юнит сервиса
sudo sh -c "printf "PSQL_USER=$PSQL_USER'\\n'PSQL_PASSWORD=$PSQL_PASSWORD'\\n'PSQL_HOST=$PSQL_HOST'\\n'PSQL_PORT=$PSQL_PORT'\\n'PSQL_DBNAME=$PSQL_DBNAME'\\n'PSQL_ADMIN=$PSQL_ADMIN'\\n'MONGO_HOST=$MONGO_HOST'\\n'MONGO_USER=$MONGO_USER'\\n'MONGO_PASSWORD=$MONGO_PASSWORD'\\n'MONGO_DATABASE=$MONGO_DATABASE" > kok"
sudo chown jarservice:jarservice /home/jarservice/creds
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /home/jarservice/sausage-store.jar||true
#Переносим артефакт в нужную папку
curl -u "$NEXUS_REPO_USER:$NEXUS_REPO_PASS" -o sausage-store.jar ${NEXUS_REPO_URL}com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store.jar /home/jarservice/sausage-store.jar||true #"jar||true" говорит, если команда обвалится — продолжай
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend.service