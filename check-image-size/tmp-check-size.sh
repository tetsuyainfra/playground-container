#!/bin/bash

OS=${OS:-linux}
ARCH=${ARCH:-amd64}

IFS=':' read -ra ARY <<< "$1"
IMAGE=${ARY[0]}
TAG=${ARY[1]}

IFS='/' read -ra ARY <<< "${IMAGE}"
if [ ${#ARY[@]} -eq 1 ]; then
  IMAGE="library/${ARY[0]}"
fi


if [ -z "$TAG" ]; then
    URL="https://hub.docker.com/v2/repositories/${IMAGE}"
else
    URL="https://hub.docker.com/v2/repositories/${IMAGE}/tags/${TAG}"
fi
echo "IMAGE: $IMAGE" 1>&2
echo "TAG  : $TAG" 1>&2
echo $OS $ARCH 1>&2
echo $URL 1>&2
echo ----- 1>&2

curl -s $URL
# curl -s $URL | jq '.images[] | {os, architecture, size}'

# curl -s https://hub.docker.com/v2/repositories/library/nginx/tags/latest | jq '.images[] | {os, architecture, size}'
