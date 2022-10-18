#!/usr/bin/env bash

set -ex

mkdir -p dist

apt-get update
apt-get install -y --no-install-recommends libbtrfs-dev libdevmapper-dev

export GO111MODULE=off

export CROSSARCH=amd64
export DOCKER_CROSSPLATFORMS=linux/$CROSSARCH
./hack/make.sh cross
mkdir -p dist/linux-$CROSSARCH
cp bundles/cross/linux/$CROSSARCH/dockerd-$VERSION dist/linux-$CROSSARCH/dockerd

export CROSSARCH=arm64
export DOCKER_CROSSPLATFORMS=linux/$CROSSARCH
./hack/make.sh cross
mkdir -p dist/linux-$CROSSARCH
cp bundles/cross/linux/$CROSSARCH/dockerd-$VERSION dist/linux-$CROSSARCH/dockerd

export CROSSARCH=ppc64le
export DOCKER_CROSSPLATFORMS=linux/$CROSSARCH
./hack/make.sh cross
mkdir -p dist/linux-$CROSSARCH
cp bundles/cross/linux/$CROSSARCH/dockerd-$VERSION dist/linux-$CROSSARCH/dockerd

export CROSSARCH=mips64le
export DOCKER_CROSSPLATFORMS=linux/$CROSSARCH
./hack/make.sh cross
mkdir -p dist/linux-$CROSSARCH
cp bundles/cross/linux/$CROSSARCH/dockerd-$VERSION dist/linux-$CROSSARCH/dockerd