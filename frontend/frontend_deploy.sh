#!/bin/bash
set +e
sudo cp -rf docker-compose.yml /home/jarservice/docker_compose/docker-compose.yml
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-store-frontend || true
docker rm sausage-store-frontend || true
#test2
set -e
cd /home/jarservice/docker_compose/
docker-compose up -d
