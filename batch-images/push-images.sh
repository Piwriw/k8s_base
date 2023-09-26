#!/bin/bash

harbor="$1"

if [ -z "$harbor" ]; then
    echo "没有提供参数。"
    exit 1  # 退出脚本，并返回非零退出状态
fi

# 设置Docker仓库用户名和密码
DOCKER_USERNAME="admin"
DOCKER_PASSWORD="Harbor12345"

# 登录到Docker仓库
docker login -u "$DOCKER_USERNAME" -p $DOCKER_PASSWORD $harbor

# 循环遍历镜像列表，并推送到Docker仓库
docker images --format "{{.Repository}}:{{.Tag}}" | while read -r image; do
    tm=$(echo "$image" | rev | cut -d '/' -f 1 )
    tag=$(echo "$tm" |rev| cut -d ':' -f 2)
    name=$(echo "$tm" |rev| cut -d ':' -f 1)
#    image_name=$(basename "$repository")  # 保留最右侧的名称部分
#    new_tag="${image_name}:${tag}"
  docker push  "$harbor/library/$name:$tag"
  echo "Push $harbor/library/$name:$tag"
done

# 登出Docker仓库
docker logout
