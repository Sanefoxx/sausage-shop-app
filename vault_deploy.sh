#!/bin/sh
set -e
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
#docker-compose stop sausage-store-vault
docker-compose up -d sausage-store-vault
cat <<EOF | docker exec -i sausage-store-vault ash
  sleep 10;
  vault login ${VAULT_TOKEN}

  vault secrets enable -path=secret kv

  vault kv put secret/sausage-store spring.datasource.password="${DATASRC_PASS_PSQL}" \
   spring.data.mongodb.uri="${MONGODB_URL}" \
   spring.datasource.url="${PSQL_DATASRC}"

  vault kv put secret/sausage-store-test spring.datasource.username="${TEST_DATASRC_PSQL_USER}"
                                         spring.datasource.password="${TEST_DATASRC_PSQL_PASS}"
EOF