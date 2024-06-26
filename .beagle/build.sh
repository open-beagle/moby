#!/bin/bash

set -ex

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'
export DOCKER_GITCOMMIT=$(git rev-parse --short HEAD)

export GOARCH=amd64
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/* dist/$GOARCH/

export GOARCH=arm64
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/* dist/$GOARCH/

export GOARCH=ppc64le
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/* dist/$GOARCH/

git apply .beagle/v24.0.2-syscall-mips64le.patch
export GOARCH=mips64le
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/* dist/$GOARCH/
git apply -R .beagle/v24.0.2-syscall-mips64le.patch
