#!/bin/sh

export LANG=ja_JP.UTF-8
#export LESSCHARSET=utf-8
#export PATH=/usr/local/bin:$PATH

alias lsa='ls -la'
alias vi='vim -u NONE'

function MACRC(){
  # Node Version Manager
  if [ -s ~/.nvm/nvm.sh ]; then
    . ~/.nvm/nvm.sh
  fi

  if [ -s /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  fi
}

function WINRC(){
  alias ls='ls --color=auto --show-control-chars'
}

if [ `uname` == 'Darwin' ]; then
  MACRC
elif [ `expr substr $(uname -s) 1 10` == 'MINGW32_NT' ]; then
  WINRC
fi
