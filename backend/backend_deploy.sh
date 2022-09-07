#!/bin/bash
set +e
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
#test7
set -e
if [ -n "$(docker ps -q --filter name=backend-blue -f health=healthy)" ];
then
    docker-compose rm -s -f backend-green
    docker-compose up -d --scale backend-green=${NODE_SCALING} backend-green
    while [ -z "$(docker ps -q --filter name=backend-green -f health=unhealthy)" ];
    do
      sleep 20;
    if ! [ -z "$(docker ps -q --filter name=backend-green -f health=healthy)" ];
    then
          echo "deployed green"
          docker-compose rm -s -f backend-blue
          break;
    fi
    done
elif [ -n "$(docker ps -q --filter name=backend-green -f health=healthy)" ];
then
    docker-compose rm -s -f backend-blue
    docker-compose up -d --scale backend-blue=${NODE_SCALING} backend-blue
    while [ -z "$(docker ps -q --filter name=backend-blue -f health=unhealthy)" ];
    do
      sleep 20;
    if ! [ -z "$(docker ps -q --filter name=backend-blue -f health=healthy)" ];
    then
        echo "deployed blue"
        docker-compose rm -s -f backend-green
        break;
    fi
    done
else
    docker-compose up -d --scale backend-blue=${NODE_SCALING} backend-blue
fi