#!/bin/bash
set +e
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-frontend || true
docker rm sausage-frontend || true
#test3
set -e
docker-compose up -d --no-deps --build frontend
