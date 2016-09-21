#!/usr/bin/env bash

CONTAINER_ID=$(docker run -u zap -p 2375:2375 -d owasp/zap2docker-weekly zap.sh -daemon -port 2375 -host 127.0.0.1 -config api.disablekey=true -config scanner.attackOnStart=true -config view.mode=attack)

# the target URL for ZAP to scan
TARGET_URL=$1

docker exec $CONTAINER_ID zap-cli -p 2375 status -t 60 && docker exec $CONTAINER_ID zap-cli -p 2375 open-url $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2375 spider $TARGET_URL

# XXX - FIXME: not only should the hard-coded host be removed, but we should pass in more-aggressive active-scan options, here
docker exec $CONTAINER_ID zap-cli -p 2375 active-scan -r $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2375 alerts

# docker logs [container ID or name]
printf "-------------------------------------------------------------------------------"
printf "ZAP-daemon log output follows"
printf "-------------------------------------------------------------------------------"
docker logs $CONTAINER_ID

docker stop $CONTAINER_ID
