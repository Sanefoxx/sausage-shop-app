#!/bin/bash
set +e
cat > .env <<EOF
VAULT_HOST=${VAULT_HOST}
VAULT_TOKEN=${VAULT_TOKEN}
EOF
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/a.lisitsin/sausage-store/sausage-backend:latest
docker stop backend || true
docker rm backend || true
set -e
docker run -d --name backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/a.lisitsin/sausage-store/sausage-backend:latest
