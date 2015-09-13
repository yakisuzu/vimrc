#!/bin/sh
pushd `dirname $0` >/dev/null

echo --------------------
echo init vim
. ./init_script/vim.sh

popd >/dev/null
read -p "pless enter"
