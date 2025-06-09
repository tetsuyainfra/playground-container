#!/bin/bash

IMAGE=${1}

IFS='/' read -ra ARY <<< "${IMAGE}"
if [ ${#ARY[@]} -eq 1 ]; then
  IMAGE="library/${ARY[0]}"
fi

curl -s https://registry.hub.docker.com/v2/repositories/${IMAGE}/tags?page_size=100 | jq -r .results[].name
