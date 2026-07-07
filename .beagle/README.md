# dockerd

<https://github.com/moby/moby>

```bash
git -C ansible-docker-moby remote add upstream git@github.com:moby/moby.git

git -C ansible-docker-moby fetch upstream

git -C ansible-docker-moby merge v28.5.1
```

## git

```bash
# ./.github/workflows/build-v28.yml
git -C ansible-docker-moby checkout release-v28 && \
git -C ansible-docker-moby merge main && \
git -C ansible-docker-moby push origin release-v28 && \
git -C ansible-docker-moby checkout main
```

## debug

```bash
# cross
docker run -it --rm \
  -v $PWD/:/go/src/github.com/docker/ \
  -v $PWD/ansible-docker-moby:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e VERSION=28.5.1-beagle \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/golang:1.24-bookworm \
  bash .beagle/build.sh
```

## components

```bash
# docker-cli-amd64
docker run -it --rm \
  -v $PWD/:/go/src/github.com/docker/ \
  -v $PWD/ansible-docker-moby:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e TARGET_ARCH=amd64 \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/docker-cli:v28.5.1-amd64 \
  bash -c "mkdir -p .tmp/$TARGET_ARCH && cp /usr/local/bin/docker .tmp/$TARGET_ARCH/ && cp /usr/libexec/docker/cli-plugins/docker-buildx .tmp/$TARGET_ARCH/"

# docker-cli-arm64
docker run -it --rm \
  -v $PWD/:/go/src/github.com/docker/ \
  -v $PWD/ansible-docker-moby:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e TARGET_ARCH=arm64 \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/docker-cli:v28.5.1-arm64 \
  bash -c "mkdir -p .tmp/$TARGET_ARCH && cp /usr/local/bin/docker .tmp/$TARGET_ARCH/ && cp /usr/libexec/docker/cli-plugins/docker-buildx .tmp/$TARGET_ARCH/"
```
