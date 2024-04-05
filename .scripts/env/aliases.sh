# Navigation
alias dev="cd ~/dev/"
alias docs="cd ~/Documents/"
alias down="cd ~/Downloads/"
alias pics="cd ~/Pictures/"
alias uni="cd /nas/documents/uni/"
alias hdd="cd ~/HDD/"
alias mail="cd ~/Mail/"
alias dots="cd ~/dev/dotfiles"
alias nas="cd /mnt/nas"

# Configs
alias zshconf='emacs -nw ~/.zshrc'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Programs
alias paru="paru --bottomup"
alias termpad="http POST https://termpad.trajkov.mk | xclip -selection clipboard"
echo "Hello World" |
alias genpass='pass generate -c'
alias doomsync='.config/emacs/bin/doom sync'
alias cb="xclip -selection clipboard"
alias emacs='emacs -nw'
alias jnb='jupyter notebook ~/dev/jupyter-notebooks'

# SSH
alias h='ssh debian'
alias pi='ssh pi'
