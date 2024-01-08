#!/bin/bash 

set -ex

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'
export DOCKER_GITCOMMIT=$(git rev-parse --short HEAD)

git apply .beagle/v24.0.2-add-seccomp-support-for-loong64.patch
export GOARCH=loong64
hack/make.sh binary
mkdir -p dist/$GOARCH
mv bundles/binary-daemon/* dist/$GOARCH/
git apply -R .beagle/v24.0.2-add-seccomp-support-for-loong64.patch