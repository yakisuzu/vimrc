#!/bin/sh

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export PATH=$PATH:~/dotfiles/bin

export NVM_DIR=~/.nvm
export GOPATH=~/work/go

#########################
# $1 alias name
# $2 path
# $3 path prefix
function MAKE_ALIAS(){
  #echo "$2"
  if [ -e "$2" ]; then
    alias $1="$3\"$2\""
  fi
}

#########################
function MACRC(){
  # for mac alias
  MAKE_ALIAS vim /Applications/MacVim.app/Contents/MacOS/Vim
  MAKE_ALIAS gvim /Applications/MacVim.app 'open '

  # Node Version Manager
  if [ -d $NVM_DIR ]; then
    . $(brew --prefix nvm)/nvm.sh
  fi
}

#########################
function WINRC(){
  export PATH=$PATH:~/../../opscode/chefdk/embedded/bin

  # for windows alias
  alias ls='ls --color=auto --show-control-chars'
  alias powershell='powershell -ExecutionPolicy unrestricted'

  # for 64bit
  if [ `uname -m` == 'x86_64' ]; then
    MAKE_ALIAS vim  "$SYSTEMDRIVE/Program Files/vim80-kaoriya-win64/vim.exe"
    MAKE_ALIAS gvim "$SYSTEMDRIVE/Program Files/vim80-kaoriya-win64/gvim.exe"
  fi
}

#########################
# main

#\[\033[31m\] Red \[\033[0m\]
#\[\033[32m\] Green \[\033[0m\]
#\[\033[36m\] Cyan \[\033[0m\]
#\[\033[1;32m\] Light Green \[\033[0m\]
#\[\033[1;36m\] Light Cyan \[\033[0m\]
PS1='\[\033[36m\]\u@\h \[\033[31m\]\w\[\033[0m\]\n$ '

alias lsa='ls -lah'
alias vi='vim -u NONE'

if [ `uname` == 'Darwin' ]; then
  MACRC
elif [ `expr substr $(uname -s) 1 7` == 'MSYS_NT' ]; then
  WINRC
fi

if [ -e ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

unset MACRC
unset WINRC
unset MAKE_ALIAS
