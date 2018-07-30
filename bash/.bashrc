#!/bin/sh

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

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
  export NVM_DIR=~/.nvm

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

  export PROGRAMFILES86="$PROGRAMFILES (x86)"
  export JAVA_HOME=$PROGRAMFILES/Java/jdk

  # PATH before
  export PATH=$PROGRAMFILES/Git/cmd:$PATH
  export PATH=$PROGRAMFILES/OpenSSH-Win64:$PATH
  export PATH=$PROGRAMFILES/vim80-kaoriya-win64:$PATH

  # PATH after
  export PATH=$PATH:$JAVA_HOME/bin
  export PATH=$PATH:$NVM_HOME
  export PATH=$PATH:$NVM_SYMLINK
  export PATH=$PATH:$PROGRAMFILES86/Yarn/bin
  export PATH=$PATH:$PROGRAMFILES/Docker/Docker/Resources/bin

  # sed drive path
  TMP_DRIVE=$(echo $SYSTEMDRIVE | cut -c 1 | tr '[A-Z]' '[a-z]')
  export PATH=$(echo $PATH | sed "s#$SYSTEMDRIVE#/${TMP_DRIVE}#g" | sed "s#\\\\#/#g")
  unset TMP_DRIVE

  # for windows alias
  alias ls='ls --color=auto --show-control-chars'
  alias powershell='powershell -ExecutionPolicy unrestricted'

  # for 64bit
  #if [ `uname -m` == 'x86_64' ]; then
  #fi
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

if [ -e ~/.bashrc_local ]; then
  . ~/.bashrc_local

  # sample
  # export PATH=$PATH:$PROGRAMFILES/Python36
  # export PATH=$PATH:$PROGRAMFILES/Python36/Scripts
  # export PATH=$PATH:$SYSTEMDRIVE/opscode/chefdk/embedded/bin
fi

if [ `uname` == 'Darwin' ]; then
  MACRC
elif [ `expr substr $(uname -s) 1 7` == 'MSYS_NT' ]; then
  WINRC
fi

export PATH=$PATH:~/dotfiles/bin

echo path
echo ----
echo $PATH | sed 's/:/\n/g'

unset MACRC
unset WINRC
unset MAKE_ALIAS
