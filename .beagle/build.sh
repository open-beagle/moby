#!/bin/bash 

set -ex

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'

export GOARCH=amd64
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/dockerd dist/$GOARCH/dockerd
mv bundles/binary-daemon/docker-proxy dist/$GOARCH/docker-proxy

export GOARCH=arm64
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/dockerd dist/$GOARCH/dockerd
mv bundles/binary-daemon/docker-proxy dist/$GOARCH/docker-proxy

export GOARCH=ppc64le
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/dockerd dist/$GOARCH/dockerd
mv bundles/binary-daemon/docker-proxy dist/$GOARCH/docker-proxy

# export GOARCH=mips64le
# hack/make.sh binary
# mkdir -p dist/$GOARCH
# mv bundles/binary-daemon/dockerd dist/$GOARCH/dockerd
# mv bundles/binary-daemon/docker-proxy dist/$GOARCH/docker-proxy

# export GOARCH=loong64
# hack/make.sh binary
# mkdir -p dist/$GOARCH
# mv bundles/binary-daemon/dockerd dist/$GOARCH/dockerd
# mv bundles/binary-daemon/docker-proxy dist/$GOARCH/docker-proxy