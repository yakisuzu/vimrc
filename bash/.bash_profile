#!/bin/sh

if [ `uname` == 'Darwin' ]; then
  # Ruby environment
  eval "$(rbenv init -)"

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
