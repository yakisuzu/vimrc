#!/bin/sh

if [ `uname` == 'Darwin' ]; then
  # Ruby environment
  eval "$(rbenv init -)"

  export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"

elif [ `expr substr $(uname -s) 1 7` == 'MSYS_NT' ]; then
  # init ssh
  eval `ssh-agent` > /dev/null
  ssh-add.exe ~/.ssh/id_rsa 2> /dev/null
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
