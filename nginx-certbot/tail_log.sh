#!/bin/bash



tail -f log/nginx/access.json | jq -R '. as $line | try fromjson catch $line'
