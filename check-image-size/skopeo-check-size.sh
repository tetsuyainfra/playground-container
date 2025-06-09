#!/bin/bash

# 未完成です
skopeo inspect docker://nginx:latest | jq '.Layers | map(.size) | add'

