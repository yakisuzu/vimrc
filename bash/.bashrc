#!/bin/sh

export LANG=ja_JP.UTF-8
#export LESSCHARSET=utf-8
#export PATH=/usr/local/bin:$PATH

alias lsa='ls -la'
alias vi='vim -u NONE'

function MACRC(){
  # Node Version Manager
  f_nvm=~/.nvm/nvm.sh
  if [ -s $f_nvm ]; then
    . $f_nvm
  fi
  unset f_nvm

  f_vim=/Applications/MacVim.app/Contents/MacOS/Vim
  if [ -s $f_vim ]; then
    alias vim=$f_vim
  fi
  unset f_vim
}

function WINRC(){
  alias ls='ls --color=auto --show-control-chars'
  alias powershell='powershell -ExecutionPolicy unrestricted'

  f_vim=$SYSTEMDRIVE/ProgramData/vim74-kaoriya-win32/vim.exe
  if [ -s $f_vim ]; then
    alias vim=$f_vim
  fi
  unset f_vim
}

if [ `uname` == 'Darwin' ]; then
  MACRC
elif [ `expr substr $(uname -s) 1 7` == 'MSYS_NT' ]; then
  WINRC
fi

unset MACRC
unset WINRC
