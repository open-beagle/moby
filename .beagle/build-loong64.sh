#!/bin/bash

set -ex

git config --global --add safe.directory $PWD

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'
export DOCKER_GITCOMMIT=$(git rev-parse --short HEAD)

git apply .beagle/v25.0.5-add-seccomp-support-for-loong64.patch
export GOARCH=loong64
hack/make.sh binary
mkdir -p .tmp/$GOARCH
mv bundles/binary-daemon/* .tmp/$GOARCH/
git apply -R .beagle/v25.0.5-add-seccomp-support-for-loong64.patch
