#!/bin/bash

set -e
set -x

# Requires that user be logged as relevant docker user

# Will push
# * justinrlee/confluent-utility:<timestamp>-amd64
# * justinrlee/confluent-utility:<timestamp>-arm64

# Will also combine into a multiarch manifest, with two tags:
# * justinrlee/confluent-utility:<timestamp>
# * justinrlee/confluent-utility:latest

export TAG=$(cat build/tag)
export IMAGE=justinrlee/confluent-utility

time docker push ${IMAGE}:${TAG}-amd64
time docker push ${IMAGE}:${TAG}-arm64v8

time docker manifest rm docker.io/${IMAGE}:${TAG}-multiarch || true
time docker manifest create \
    ${IMAGE}:${TAG}-multiarch \
    --amend ${IMAGE}:${TAG}-amd64 \
    --amend ${IMAGE}:${TAG}-arm64v8

time docker manifest push ${IMAGE}:${TAG}-multiarch

time docker manifest rm docker.io/${IMAGE}:latest || true
time docker manifest create \
    ${IMAGE}:latest \
    --amend ${IMAGE}:${TAG}-amd64 \
    --amend ${IMAGE}:${TAG}-arm64v8

time docker manifest push ${IMAGE}:latest