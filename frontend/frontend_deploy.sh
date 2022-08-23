#!/bin/bash
set +e
#
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/a.lisitsin/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d --name frontend \
    --network=sausage_network \
    --publish 8080:80 \
    --restart always \
    --pull always \
    gitlab.praktikum-services.ru:5050/a.lisitsin/sausage-store/sausage-frontend:latest