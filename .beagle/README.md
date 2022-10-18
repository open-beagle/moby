# git

<https://github.com/moby/moby>

```bash
git remote add upstream git@github.com:moby/moby.git

git fetch upstream

git merge v20.10.18
```

## build

```bash
# amd64
docker run -it --rm \
-v $PWD/:/go/src/github.com/docker/docker \
-w /go/src/github.com/docker/docker \
-e VERSION=20.10.18-beagle \
-e PLATFORM="Beagle Cloud Team 2018-2028" \
-e PRODUCT="Beagle Cloud Team 2018-2028" \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-bullseye \
bash .beagle/build.sh
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e PLUGIN_PATH="/cache/open-beagle/moby" \
  -e PLUGIN_MOUNT="./" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e PLUGIN_PATH="/cache/open-beagle/moby" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
