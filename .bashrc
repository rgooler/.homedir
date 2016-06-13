#THIS FILE IS STORED IN A REPO, AND PROBABLY MANAGED BY PUPPET

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#Setup colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#try to find git-prompt.sh if __git_ps1 was not automatically provided.
if ! type -t __git_ps1 &> /dev/null ; then
    #cygwin (non-msysgit): try to find git-prompt.sh
    gitprompt_home="`which git`/../../etc/git-prompt.sh" 
    [ -f "$gitprompt_home" ] && source "$gitprompt_home"
fi

#bash completion; this also provides __git_ps1 on some systems
if command -v brew > /dev/null 2>&1 && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
elif [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# Otherwise, hack in my 'should always work' version
if ! type -t __git_ps1 &> /dev/null ; then
    . ~/bin/git-prompt.sh
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Allow a local, editable bashrc file
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

export PATH=$PATH:$HOME/bin
export EDITOR=vim
# set git prompt iff function exists.
LOCALCOLOR='\[\033[01;32m\]'
if [[ "$SSH_CONNECTION" == "" ]]; then 
    LOCALCOLOR='\[\033[01;95m\]'
fi

PS1Prefix='\n'${LOCALCOLOR}'\u@\h\[\033[1;34m\]:\[\033[1;35m\]\w\[\033[31m\]$'
GITPS1=''
PS1Postfix='\n'${LOCALCOLOR}'$\[\033[00m\] '

if type -t __git_ps1 &> /dev/null ; then
    GITPS1='(__git_ps1 "(%s)")'
    GIT_PS1_STATESEPARATOR=""
    GIT_PS1_SHOWUPSTREAM="verbose"
    GIT_PS1_SHOWCOLORHINTS=1
fi

export PS1=${PS1Prefix}${GITPS1}${PS1Postfix}
export PATH=$PATH:~/bin

#Save and load history when prompt appears.
export PROMPT_COMMAND="history -a; history -n"
export PYTHONSTARTUP=~/.pystartup

# Allow Ruby rbenv stuff to work
if [ -f ~/.rbenv ]; then
  eval "$(rbenv init -)"
fi

export GOPATH=$HOME
