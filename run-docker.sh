#!/usr/bin/env bash

CONTAINER_ID=$(docker run -u zap -p 2375:2375 -d thc202/zap2docker-dns zap.sh -daemon -port 2375 -host 127.0.0.1 -config api.disablekey=true -config scanner.attackOnStart=true -config view.mode=attack -config connection.dnsTtlSuccessfulQueries=-1 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true)

# the target URL for ZAP to scan
TARGET_URL=$1

docker exec $CONTAINER_ID zap-cli -p 2375 status -t 60 && docker exec $CONTAINER_ID zap-cli -p 2375 open-url $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2375 spider $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2375 active-scan -r $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2375 alerts

# docker logs [container ID or name]
divider==================================================================
printf "\n"
printf "$divider"
printf "ZAP-daemon log output follows"
printf "$divider"
printf "\n"

docker logs $CONTAINER_ID

docker stop $CONTAINER_ID
