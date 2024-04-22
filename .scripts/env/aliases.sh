# Configs
alias zshconf='emacsclient -nw ~/.zshrc'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Programs
alias paru="paru --bottomup"
alias termpad="http POST https://termpad.trajkov.mk | xclip -selection clipboard"
alias genpass='pass generate -c'
alias doomsync='.config/emacs/bin/doom sync && systemctl restart --user emacs'
alias cb="xclip -selection clipboard"
alias emacs='emacsclient -nw -c'

# SSH
alias h='ssh debian'
alias pi='ssh pi'
