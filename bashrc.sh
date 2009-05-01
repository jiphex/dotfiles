#! /bin/bash
# James Hannah - Bash Prompt.

# If no prompt, quit here.
[ -z "$PS1" ] && exit

# Get the important things sorted first
export EDITOR=vim

# Lets define some colors
# dark or BRIGHT
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
gray='\[\e[0;30m\]'
GRAY='\[\e[1;30m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
NC='\[\e[0m\]' # No Colour
NOCOL=$NC

# Do the prompt:
if [ $UID -eq 0 ]; then export PS1="${RED}\h \$${NC} "; else export PS1="${GREEN}\h \$${NC} "; fi

# Fiddle with the history
export HISTCONTROL=ignoredups #no dups
export HISTCONTROL=ignoreboth #no same successive
shopt -s histappend # don't overwrite history - append instead

# Make sure we check the window size after each command:
shopt -s checkwinsize

# Fix spelling errors in cd
shopt -s cdspell

# Colour ls
eval "`dircolors -b`"
alias ls='ls --color=auto'
export CLICOLOR='CLICOLOR'

# Fat fingers aliasing:
alias sl='ls'
alias rm='rm -i'

# Some more useful aliasing
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias e='$EDITOR'
alias g='git'

# Some generic additions to the path.
PATH="/opt/local/bin:/opt/bin:/usr/local/bin:$PATH"

# Let's do some clever ssh completion:
# (Commented for now for compatibility)
#complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

# If ~/bin exists, add it to the path:
if [ -d ~/bin ]; then
	PATH="~/bin:$PATH"
fi
export PATH

# Let's do some git stuff
if [ -f ~/.gitvimrc ]; then
	export GIT_EDITOR="vim -S ~/.gitvimrc +start"
else
	# If .gitvimrc doesn't exist then just start vim and don't worry about the hard line-break
	export GIT_EDITOR="vim +start"
fi

# Load local bash script if it exists
if [ -f ~/.bash_local ]; then
	source ~/.bash_local
fi
