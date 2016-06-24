#!/usr/bin/env bash

CONTAINER_ID=$(docker run -u zap -p 8090:8090 -d owasp/zap2docker-weekly zap.sh -daemon -port 8090 -host 0.0.0.0 -config api.disablekey=true)

# XXX - FIXME: should smartly listen for ZAP-readiness, rather than hard-code a sleep
sleep 20

docker exec $CONTAINER_ID zap-cli open-url https://www.allizom.org/en-US/firefox/

docker exec $CONTAINER_ID zap-cli spider https://www.allizom.org/en-US/firefox/

# XXX - FIXME: not only should the hard-coded host be removed, but we should pass in more-aggressive active-scan options, here
docker exec $CONTAINER_ID zap-cli active-scan https://www.allizom.org/en-US/firefox/

# docker logs [container ID or name]
docker logs $CONTAINER_ID

docker stop $CONTAINER_ID
