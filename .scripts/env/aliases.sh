# Navigation
alias dev="cd ~/dev/"
alias docs="cd ~/Documents/"
alias down="cd ~/Downloads/"
alias pics="cd ~/Pictures/"
alias cs="cd ~/Documents/uni/"
alias hdd="cd ~/HDD/"
alias mail="cd ~/Mail/"
alias dots="cd ~/Dev/dotfiles"
alias nas="cd ~/Dev/dotfiles"

# Configs
alias zshconf='emacs -nw ~/.zshrc'
alias i3conf='emacs -nw ~/.config/i3/config'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Programs
alias paru="paru --bottomup"
alias d='ls'
alias vim="nvim"
alias tb="nc termbin.com 9999 | xclip -selection clipboard"
alias genpass='pass generate -c'
alias doomsync='.config/emacs/bin/doom sync'
alias cb="xclip -selection clipboard"
alias emacs='emacs -nw'

alias jnb='jupyter notebook ~/Dev/notebooks'

# SSH
alias h='ssh ivche@192.168.100.220'
alias pi='ssh ivche@192.168.100.13'
