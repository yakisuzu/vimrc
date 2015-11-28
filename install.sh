#!/bin/bash
pushd `dirname $0` >/dev/null

echo --------------------
echo init bash
. ./script/bash.sh

echo --------------------
echo init git
. ./script/git.sh

echo --------------------
echo init vim
. ./script/vim.sh

popd >/dev/null
read -p "pless enter"
