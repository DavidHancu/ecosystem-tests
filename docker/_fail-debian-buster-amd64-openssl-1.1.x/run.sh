#!/bin/sh

set -eux
export DEBUG="*"

yarn install

DOCKER_PLATFORM_ARCH="linux/amd64"
PRISMA_DOCKER_IMAGE_NAME="prisma-debian-buster-amd64-openssl-undefined"

docker buildx build --load \
  --platform="${DOCKER_PLATFORM_ARCH}" \
  --build-context app=. \
  --build-context utils=../_utils \
  --build-arg DEBUG=${DEBUG} \
  --build-arg PRISMA_TELEMETRY_INFORMATION="${PRISMA_TELEMETRY_INFORMATION}" \
  --build-arg PRISMA_CLIENT_ENGINE_TYPE=${PRISMA_CLIENT_ENGINE_TYPE} \
  --build-arg PRISMA_CLI_QUERY_ENGINE_TYPE=${PRISMA_CLIENT_ENGINE_TYPE} \
  --build-arg CI=${CI} \
  . -t "${PRISMA_DOCKER_IMAGE_NAME}" \
  --progress plain

docker run -p 3000:3000 \
  -e DEBUG=${DEBUG} \
  -e DATABASE_URL=${DATABASE_URL} \
  -e CI=${CI} \
  -e PRISMA_CLIENT_ENGINE_TYPE=${PRISMA_CLIENT_ENGINE_TYPE} \
  -e PRISMA_CLI_QUERY_ENGINE_TYPE=${PRISMA_CLIENT_ENGINE_TYPE} \
  -e PRISMA_TELEMETRY_INFORMATION="${PRISMA_TELEMETRY_INFORMATION}" \
  "${PRISMA_DOCKER_IMAGE_NAME}" &

sleep 15