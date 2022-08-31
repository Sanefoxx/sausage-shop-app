#!/bin/bash
set +e
sudo cp -rf docker-compose.yml /home/jarservice/docker_compose/docker-compose.yml
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-store-backend || true
docker rm sausage-store-backend || true
#test
set -e
cd /home/jarservice/docker_compose/
docker-compose up -d --no-deps --build sausage-store-backend