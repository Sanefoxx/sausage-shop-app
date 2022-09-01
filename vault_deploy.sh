#!/bin/sh
set -e
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker-compose stop vault
docker rm vault || true
docker-compose up -d vault
cat <<EOF | docker exec -i vault ash
  sleep 10;
  vault login ${VAULT_TOKEN}

  vault secrets enable -path=secret kv

  vault kv put secret/sausage-store spring.datasource.password="${DATASRC_PASS_PSQL}" \
   spring.datasource.username="${DATASRC_USER}" \
   spring.datasource.url="${PSQL_DATASRC}" \
   spring.data.mongodb.uri="${MONGODB_URL}"

  vault kv put secret/sausage-store-test spring.datasource.username="${TEST_DATASRC_PSQL_USER}" \
                                         spring.datasource.password="${TEST_DATASRC_PSQL_PASS}"
EOF
