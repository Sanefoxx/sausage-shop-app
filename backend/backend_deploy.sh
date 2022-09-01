#!/bin/bash
set +e
sudo cp -rf docker-compose.yml /home/jarservice/docker_compose/docker-compose.yml
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-backend || true
docker rm sausage-backend || true
#test4
set -e
docker-compose up -d --no-deps --build backend