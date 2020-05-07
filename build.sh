#!/usr/bin/env bash

NAME=$1

cd "./${NAME}" || exit 1

echo -e "\033[34m[ Start '${NAME}' ]\033[0m"

docker build -q -t starudream/"${NAME}":latest .

echo -e "\033[32m[ Login Docker Hub ]\033[0m"
docker login -u starudream -p "${DOCKER_TOKEN}"
echo -e "\033[32m[ Publish Docker Hub ]\033[0m"
docker push starudream/"${NAME}":latest

echo -e "\033[32m[ Login GitHub Package ]\033[0m"
docker login -u starudream -p "${PACKAGE_TOKEN}" docker.pkg.github.com
echo -e "\033[32m[ Publish GitHub Package ]\033[0m"
docker tag starudream/"${NAME}":latest docker.pkg.github.com/starudream/workflows-test/"${NAME}":latest
docker push docker.pkg.github.com/starudream/workflows-test/"${NAME}":latest

echo -e "\033[32m[ Login Aliyun Docker ]\033[0m"
docker login -u "${ALIYUN_DOCKER_USERNAME}" -p "${ALIYUN_DOCKER_TOKEN}" registry.cn-shanghai.aliyuncs.coml
echo -e "\033[32m[ Publish Aliyun Docker ]\033[0m"
docker tag starudream/"${NAME}":latest registry.cn-shanghai.aliyuncs.com/starudream/"${NAME}":latest
docker push registry.cn-shanghai.aliyuncs.com/starudream/"${NAME}":latest

echo -e "\033[34m[ End '${NAME}' ]\033[0m"

cd "../"
