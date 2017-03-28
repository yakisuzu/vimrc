#!/bin/sh

pushd `dirname $0` >/dev/null

if [ ! -f netrc ]; then
  cp netrc.sample netrc
fi
cp -r ~/.ssh .

docker build -t workcent:0.0.1 .

mkdir -p work
docker run -it --name=workcent -v work://work workcent:0.0.1

popd >/dev/null

