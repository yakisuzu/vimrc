#!/bin/sh
pushd `dirname $0` >/dev/null

echo --------------------
echo init bash
. ./init_script/bash.sh

echo --------------------
echo init git
. ./init_script/git.sh

echo --------------------
echo init vim
. ./init_script/vim.sh

popd >/dev/null
read -p "pless enter"
