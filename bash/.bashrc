#!/bin/sh

export LANG=ja_JP.UTF-8
#export LESSCHARSET=utf-8
#export PATH=/usr/local/bin:$PATH

export NVM_DIR=~/.nvm

alias lsa='ls -la'
alias vi='vim -u NONE'

# $1 alias name
# $2 path
# $3 path prefix
function MAKE_ALIAS(){
  if [ -e $2 ]; then
    alias $1="$3$2"
  fi
}

function MACRC(){
  # Node Version Manager
  if [ -d $NVM_DIR ]; then
    . $(brew --prefix nvm)/nvm.sh
  fi

  MAKE_ALIAS vim /Applications/MacVim.app/Contents/MacOS/Vim
  MAKE_ALIAS gvim /Applications/MacVim.app "open "
}

function WINRC(){
  alias ls='ls --color=auto --show-control-chars'
  alias powershell='powershell -ExecutionPolicy unrestricted'

  MAKE_ALIAS vim $SYSTEMDRIVE/ProgramData/vim74-kaoriya-win32/vim.exe
  MAKE_ALIAS gvim $SYSTEMDRIVE/ProgramData/vim74-kaoriya-win32/gvim.exe
}

if [ `uname` == 'Darwin' ]; then
  MACRC
elif [ `expr substr $(uname -s) 1 7` == 'MSYS_NT' ]; then
  WINRC
fi

unset MACRC
unset WINRC
unset MAKE_ALIAS
