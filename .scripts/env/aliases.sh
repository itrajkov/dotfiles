# Navigation
alias db="cd ~/Dropbox"
alias dev="cd ~/Dev/"
alias docs="cd ~/Documents/"
alias down="cd ~/Downloads/"
alias pics="cd ~/Pictures/"
alias cs="cd ~/Dropbox/College/"
alias hdd="cd ~/HDD/"
alias mail="cd ~/Mail/"
alias dotfiles="cd ~/Dev/dotfiles"

# Configs
alias zshconf='nvim ~/.zshrc'
alias i3conf='nvim ~/.config/i3/config'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Programs
alias d='ls'
alias cat="bat"
alias vim="nvim"
alias r="ranger"
alias t='tmuxp load'
alias diskspace='ncdu'
alias tb="nc termbin.com 9999"
alias genpass='pass generate -c'
alias doomsync='~/.emacs.d/bin/doom sync && systemctl restart emacs --user'
alias serv='ssh root@candywatch.net'
alias emacs='emacsclient -c --nw'

alias tl='todoist sync && todoist list'
alias ta='todoist sync && todoist add'
alias jnb='jupyter notebook ~/Dev/notebooks'
alias vpnup='sudo wg-quick up wg0'
alias killvpn='sudo wg-quick down wg0'

