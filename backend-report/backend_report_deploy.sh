#!/bin/bash
set +e
cat > .env <<EOF
VAULT_HOST=${VAULT_HOST}
VAULT_TOKEN=${VAULT_TOKEN}
EOF
sudo cp -rf docker-compose.yml /home/jarservice/docker_compose/docker-compose.yml
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
set -e
cd /home/jarservice/docker_compose/
docker-compose up -d

