# dockerd

<https://github.com/moby/moby>

```bash
git remote add upstream git@github.com:moby/moby.git

git fetch upstream

git merge v28.3.2
```

## build

```bash
# cross
docker run -it \
  --rm \
  -v $PWD/:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e VERSION=28.3.2-beagle \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/golang:1.24-bookworm \
  bash .beagle/build.sh
```

## components

```bash
# docker-cli-amd64
docker run -it \
  --rm \
  -v $PWD/:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e TARGET_ARCH=amd64 \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/docker-cli:v28.3.2-amd64 \
  bash -c "mkdir -p .tmp/$TARGET_ARCH && cp /usr/local/bin/docker .tmp/$TARGET_ARCH/ && cp /usr/libexec/docker/cli-plugins/docker-buildx .tmp/$TARGET_ARCH/"

# docker-cli-arm64
docker run -it \
  --rm \
  -v $PWD/:/go/src/github.com/docker/docker \
  -w /go/src/github.com/docker/docker \
  -e TARGET_ARCH=arm64 \
  -e PLATFORM="© 2018 BeagleCloud Team" \
  registry.cn-qingdao.aliyuncs.com/wod/docker-cli:v28.3.2-arm64 \
  bash -c "mkdir -p .tmp/$TARGET_ARCH && cp /usr/local/bin/docker .tmp/$TARGET_ARCH/ && cp /usr/libexec/docker/cli-plugins/docker-buildx .tmp/$TARGET_ARCH/"
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$S3_ENDPOINT_ALIYUN \
  -e PLUGIN_ACCESS_KEY=$S3_ACCESS_KEY_ALIYUN \
  -e PLUGIN_SECRET_KEY=$S3_SECRET_KEY_ALIYUN \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="moby" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$S3_ENDPOINT_ALIYUN \
  -e PLUGIN_ACCESS_KEY=$S3_ACCESS_KEY_ALIYUN \
  -e PLUGIN_SECRET_KEY=$S3_SECRET_KEY_ALIYUN \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="moby" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
