#!/bin/sh
set -e

docker buildx create --driver docker-container --bootstrap --use
docker buildx build -o type=docker,dest=coredns-${RELEASE}.tar -t localdomain/coredns:${RELEASE} --platform linux/${ARCH} /coredns
