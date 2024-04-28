# dockerd

<https://github.com/moby/moby>

```bash
git remote add upstream git@github.com:moby/moby.git

git fetch upstream

git merge v26.1.0
```

## build

```bash
# cross
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/docker/docker \
-w /go/src/github.com/docker/docker \
-e VERSION=26.1.0-beagle \
-e PLATFORM="Beagle Cloud Team 2023-2028" \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.21 \
bash .beagle/build.sh

# loong64
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/docker/docker \
-w /go/src/github.com/docker/docker \
-e VERSION=26.1.0-beagle \
-e PLATFORM="Beagle Cloud Team 2023-2028" \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.21-loongnix \
bash .beagle/build-loong64.sh
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="moby" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="moby" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
