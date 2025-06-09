#!/bin/bash

if [ $# -ne 2 ];then
    echo "Usage: $0 IMAGE_NAME TAG_NAME";
    exit 1
fi

OS=${OS:-linux}
ARCH=${ARCH:-amd64}

IMAGE=${1}
TAG=${2}

IFS='/' read -ra ARY <<< "${IMAGE}"
if [ ${#ARY[@]} -eq 1 ]; then
  IMAGE="library/${ARY[0]}"
fi
URL="https://hub.docker.com/v2/repositories/${IMAGE}/tags/${TAG}"


echo "IMAGE: $IMAGE" 1>&2
echo "TAG  : $TAG" 1>&2
echo $OS $ARCH 1>&2
echo $URL 1>&2
echo ----- 1>&2

curl -s $URL |  jq '.images[] | select(.architecture == "amd64" and .os == "linux") | { os, architecture, size,
    size_human: (((.size / 1000 / 1000) * 100 | round / 100) | tostring + "MB") }'

