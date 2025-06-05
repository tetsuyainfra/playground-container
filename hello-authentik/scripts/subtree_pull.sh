#!/bin/bash

SCRIPT_ROOT=$(cd $(dirname $0);pwd)
WORKSPACE_DIR=$(dirname $SCRIPT_ROOT)
GIT_DIR=$(dirname $WORKSPACE_DIR)
echo "SCRIPT_ROOT  :" $SCRIPT_ROOT
echo "WORKSPACE_DIR:" $WORKSPACE_DIR
echo "GIT_DIR      :" $GIT_DIR

pushd $GIT_DIR
    git subtree pull --prefix=$(basename $WORKSPACE_DIR)/express-auth-example --squash subtree-authjs main
popd