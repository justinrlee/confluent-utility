#!/bin/bash

set -e
set -x


# Will build (but not push):
# * justinrlee/confluent-utility:<timestamp>-amd64
# * justinrlee/confluent-utility:<timestamp>-arm64

. ./.env
envsubst < ./template/Dockerfile.amd64 > ./build/Dockerfile.amd64
envsubst < ./template/Dockerfile.arm64v8 > ./build/Dockerfile.arm64v8

export TAG=${TAG:-$(date +%Y-%m-%d-%H-%M-%S)}
export IMAGE=justinrlee/confluent-utility

echo $TAG > build/tag

time docker build -t ${IMAGE}:${TAG}-amd64 --platform linux/amd64 --build-arg ARCH=amd64 -f ./build/Dockerfile.amd64 .
time docker build -t ${IMAGE}:${TAG}-arm64v8 --platform linux/arm64/v8 --build-arg ARCH=arm64/v8 -f ./build/Dockerfile.arm64v8 .
