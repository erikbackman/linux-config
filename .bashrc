# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias du='du -h -a --total'
alias girth='du -h -a --total'
alias free='free -h'
alias df='df -h'
alias ls='ls --color=auto'
alias la='ls -alh'
alias ll='ls -lh'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias cal='cal -3'

export PATH="/opt/texlive/2023/bin/x86_64-linux:$PATH"
export PATH="/home/ebn/.local/bin:$PATH"

export EDITOR=emacs
export SVDIR=~/service

PS1='\W \$ '
