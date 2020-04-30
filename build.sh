#!/usr/bin/env bash

NAME=$1

cd "./${NAME}" || exit 1

echo -e "\033[34m[ Start '${NAME}' ]\033[0m"

docker build -q -t starudream/"${NAME}":latest .

echo -e "\033[32m[ Login Docker Hub ]\033[0m"
docker login -u starudream -p "${DOCKER_TOKEN}"
echo -e "\033[32m[ Publish Docker Hub ]\033[0m"
docker push starudream/"${NAME}":latest

echo -e "\033[32m[ Login Aliyun Docker ]\033[0m"
docker login -u "${ALIYUN_DOCKER_USERNAME}" -p "${ALIYUN_DOCKER_TOKEN}" registry.cn-shanghai.aliyuncs.com 1>/dev/null
echo -e "\033[32m[ Publish Aliyun Docker ]\033[0m"
docker tag starudream/"${NAME}":latest registry.cn-shanghai.aliyuncs.com/starudream/"${NAME}":latest 1>/dev/null
docker push registry.cn-shanghai.aliyuncs.com/starudream/"${NAME}":latest

echo -e "\033[34m[ End '${NAME}' ]\033[0m"

cd "../"
