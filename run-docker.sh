#!/usr/bin/env bash

docker run -u zap -p 8080:8080 -d owasp/zap2docker-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true

# next, we need to do a docker exec [container ID or name] zap-cli open-url
# XXX - FIXME: we need to dynamically pass in the container ID / name

# docker exec [container ID or name] zap-cli active-scan 'https://www.allizom.org'
# XXX - FIXME: we need to dynamically pass in the container ID / name

# docker logs [container ID or name]
# XXX - FIXME: we need to dynamically pass in the container ID / name
