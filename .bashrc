# -*- compile-command: "source ~/.bashrc" -*-
#

# Locale
export LANG="en_US.UTF-8"
export LC_COLLATE="C.UTF-8"

# Aliases
alias du='du -h -a --total'
alias girth='du -h -a --total'
alias free='free -h'
alias df='df -h'
alias la='ls -alh'
alias ll='ls -lh'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias e="emacsclient --tty --socket-name=/tmp/emacs$(id -u)/server"

if [ "dumb" == "$TERM" ]; then
    alias less='cat'
    alias more='cat'
    export PAGER=cat
fi

## Completions
source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/rc-status
source /usr/share/bash-completion/completions/rc-update
source /usr/share/bash-completion/completions/eselect
# source /usr/share/bash-completion/completions/emerge

# Env
export PATH="$HOME/.local/bin/:$PATH"
export EDITOR='emacs -nw'
export MENUCONFIG_COLOR=mono

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc

# Carp
export PATH="$HOME/carp/bin:$PATH"
export CARP_DIR="$HOME/carp/"

export TERM=xterm-256color

GPG_TTY=$(tty)
export GPG_TTY

# if [[ -z "$SSH_AGENT_PID" ]]; then
#     exec ssh-agent bash
#     ssh-add ~/.ssh/id_github
# fi

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
