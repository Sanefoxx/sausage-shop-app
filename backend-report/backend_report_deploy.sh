#!/bin/bash
set +e
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-backend-report || true
docker rm sausage-backend-report || true
set -e
docker-compose up -d --no-deps --build backend-report

