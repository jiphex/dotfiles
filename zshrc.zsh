# aliases - self explanatory
alias vi="vim"
alias ls="ls --color"

# ok, prompt is slightly complicated.
setopt prompt_subst
autoload colors    
colors             
autoload -Uz vcs_info
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}";                       
export PS1='${PR_BRIGHT_GREEN}%m%# ${PR_RESET}'
# prompt done

# doing the keyboard now
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '\e[1~' beginning-of-line
bindkey '^[[H'  beginning-of-line #mac
bindkey '\e[4~' end-of-line
bindkey '^[[F'  end-of-line #mac
bindkey '^[[4~' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# activate MAGIC completion...
zmodload zsh/complist
autoload -U compinit && compinit
### comment out the next line and un-comment the following 5 lines
zstyle ':completion:::::' completer _complete _approximate
#_force_rehash() {
#  (( CURRENT == 1 )) && rehash
#  return 1	# Because we didn't really complete anything
#}
#zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

# craploads of history plz
HISTSIZE=99999
HISTFILE=~/.zsh_history
SAVEHIST=99999

# contrast colors for ls
export LSCOLORS=Dxfxcxdxbxegedabagacad
export CLICOLOR=CLICOLOR

# some local path additions
export PATH="/opt/local/bin:/Users/james/.gem/ruby/1.8/bin:$PATH"

# do autocompletion like bash, double tab for competion
setopt BASH_AUTO_LIST

# completion cache, dont remember where this is from
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# case-insensitive completion if we're on OSX as the underlying filesystem is case insensitive
if [ -d /Applications ]; then
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi
