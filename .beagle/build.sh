#!/bin/bash

set -ex

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'
export DOCKER_GITCOMMIT=$(git rev-parse --short HEAD)

export GOARCH=amd64
hack/make.sh binary
mkdir -p bundles/$GOARCH
mv bundles/binary-daemon/* bundles/$GOARCH/

export GOARCH=arm64
hack/make.sh binary
mkdir -p bundles/$GOARCH
mv bundles/binary-daemon/* bundles/$GOARCH/
