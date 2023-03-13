#!/usr/bin/env bash

set -ex

apt-get update
apt-get install -y --no-install-recommends libbtrfs-dev libdevmapper-dev

export GO111MODULE=off
export DOCKER_LDFLAGS="-s -w"

export GOARCH=amd64
export DOCKER_CROSSPLATFORMS=linux/$GOARCH
./hack/make.sh binary
mkdir -p dist/linux-$GOARCH
cp bundles/binary-daemon/dockerd dist/linux-$GOARCH/dockerd
cp bundles/binary-daemon/docker-proxy dist/linux-$GOARCH/docker-proxy

export GOARCH=arm64
export DOCKER_CROSSPLATFORMS=linux/$GOARCH
./hack/make.sh binary
mkdir -p dist/linux-$GOARCH
cp bundles/binary-daemon/dockerd dist/linux-$GOARCH/dockerd
cp bundles/binary-daemon/docker-proxy dist/linux-$GOARCH/docker-proxy

export GOARCH=ppc64le
export DOCKER_CROSSPLATFORMS=linux/$GOARCH
./hack/make.sh binary
mkdir -p dist/linux-$GOARCH
cp bundles/binary-daemon/dockerd dist/linux-$GOARCH/dockerd
cp bundles/binary-daemon/docker-proxy dist/linux-$GOARCH/docker-proxy

git apply .beagle/0001-syscall-mips64le.patch

export GOARCH=mips64le
export DOCKER_CROSSPLATFORMS=linux/$GOARCH
./hack/make.sh binary
mkdir -p dist/linux-$GOARCH
cp bundles/binary-daemon/dockerd dist/linux-$GOARCH/dockerd
cp bundles/binary-daemon/docker-proxy dist/linux-$GOARCH/docker-proxy