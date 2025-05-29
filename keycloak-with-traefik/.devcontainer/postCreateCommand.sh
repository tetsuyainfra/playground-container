#!/bin/sh

echo Running ${0}
echo user: $USER
echo 'eval "$(mise activate bash)"' >> ~/.bash_aliases

echo "--- check config ---"
mvn --version