#!/usr/bin/env bash

docker run -u zap -p 8080:8080 -d owasp/zap2docker-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true

# XXX - FIXME: should smartly listen for ZAP-readiness, rather than hard-code a sleep
sleep 10

docker exec $(docker ps -lq) zap-cli open-url https://www.allizom.org/en-US/firefox/

docker exec $(docker ps -lq) zap-cli active-scan https://www.allizom.org/en-US/firefox/

# docker logs [container ID or name]
docker logs $(docker ps -lq)

docker stop $(docker ps -lq)
