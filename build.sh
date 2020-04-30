#!/usr/bin/env bash

NAME=$1

cd "./${NAME}" || exit 1

echo -e "\033[34m[ Build '${NAME}' ]\033[0m"
docker build -q -t starudream/"${NAME}":latest .

echo -e "\033[32m[ Publish Docker Hub ]\033[0m"
docker login -u starudream -p "${secrets.DOCKER_TOKEN}"
docker push starudream/"${NAME}":latest

echo -e "\033[32m[ Publish Aliyun Docker Hub ]\033[0m"
docker login -u "${secrets.ALIYUN_DOCKER_USERNAME}" -p "${secrets.ALIYUN_DOCKER_TOKEN}" registry.cn-hangzhou.aliyuncs.com
docker tag starudream/"${NAME}":latest registry.cn-shanghai.aliyuncs.com/starudream/"${NAME}":latest

cd "../"
