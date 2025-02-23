#!/bin/bash

set -ex

git config --global --add safe.directory $PWD

export GO111MODULE=auto

export DOCKER_EXPERIMENTAL=1
export DOCKER_LDFLAGS='-s -w'
export DOCKER_GITCOMMIT=$(git rev-parse --short HEAD)

## loong64 patch
if $(git diff --quiet profiles/seccomp/seccomp_linux.go); then
  git apply .beagle/v27.3.1-loong64.patch
fi

export GOARCH=loong64
hack/make.sh binary
mkdir -p .tmp/$GOARCH
mv bundles/binary-daemon/* .tmp/$GOARCH/

git apply -R .beagle/v27.3.1-loong64.patch
