#!/usr/bin/env bash

CONTAINER_ID=$(docker run -u zap -p 2375:2375 -d owasp/zap2docker-weekly zap.sh -daemon -port 2375 -host 127.0.0.1 -config api.disablekey=true)

# XXX - FIXME: should smartly listen for ZAP-readiness, rather than hard-code a sleep
sleep 20

docker exec $CONTAINER_ID zap-cli -p 2375 open-url https://www.allizom.org/en-US/firefox/

docker exec $CONTAINER_ID zap-cli -p 2375 spider https://www.allizom.org/en-US/firefox/

# XXX - FIXME: not only should the hard-coded host be removed, but we should pass in more-aggressive active-scan options, here
docker exec $CONTAINER_ID zap-cli -p 2375 active-scan https://www.allizom.org/en-US/firefox/

# docker logs [container ID or name]
docker logs $CONTAINER_ID

docker stop $CONTAINER_ID
