#!/bin/bash

SCRIPT_ROOT=$(cd $(dirname $0);pwd)
WORKSPACE_DIR=$(dirname $SCRIPT_ROOT)
GIT_DIR=$(dirname $WORKSPACE_DIR)
echo "SCRIPT_ROOT  :" $SCRIPT_ROOT
echo "WORKSPACE_DIR:" $WORKSPACE_DIR
echo "GIT_DIR      :" $GIT_DIR

pushd $GIT_DIR
    git remote add subtree-authjs https://github.com/nextauthjs/express-auth-example.git
    git remote -v
    # only first commit
    # git subtree add --prefix=$(basename $WORKSPACE_DIR)/express-auth-example --squash subtree-authjs main
popd