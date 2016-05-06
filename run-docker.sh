#!/usr/bin/env bash

docker run -u zap -p 8080:8080 -d owasp/zap2docker-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true
