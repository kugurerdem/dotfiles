#
# ~/.bash_profile
#

set -o vi
alias sudo="sudo "

alias info="info --vi-keys"
alias ls="ls -p"
alias nt="nohup $TERM >/dev/null 2>&1 &"
alias e='nvim `fzf`'
alias vw="nvim -c 'norm \ww'"
alias lock="i3lock -c 000000 && gpgconf --reload gpg-agent"

alias gi=git
alias news=newsboat

setxkbmap -option caps:swapescape
