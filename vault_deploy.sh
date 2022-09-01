#!/bin/sh
set -e
echo "111111"
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
echo "222222"
docker-compose stop vault
echo "33333"
docker-compose up -d vault
echo "44444444"
cat <<EOF | docker exec -i vault ash
  sleep 10;
  vault login ${VAULT_TOKEN}

  vault secrets enable -path=secret kv

  vault kv put secret/sausage-store spring.datasource.password="${DATASRC_PASS_PSQL}" \
   spring.data.mongodb.uri="${MONGODB_URL}" \
   spring.datasource.url="${PSQL_DATASRC}"

  vault kv put secret/sausage-store-test spring.datasource.username="${TEST_DATASRC_PSQL_USER}"
                                         spring.datasource.password="${TEST_DATASRC_PSQL_PASS}"
EOF