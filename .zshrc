EDITOR=nvim
LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

export ZSH="/home/ivche/.oh-my-zsh"
lazynvm() {
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  if [ -f "$NVM_DIR/bash_completion" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}

nvm() {
  lazynvm 
  nvm $@
}
 
node() {
  lazynvm
  node $@
}
 
npm() {
  lazynvm
  npm $@
}

npx() {
  lazynvm
  npx $@
}

ZSH_THEME="robbyrussell"

plugins=(git archlinux copydir vi-mode web-search colorize copyfile extract z zsh-syntax-highlighting)

#web-search plugin config
ZSH_WEB_SEARCH_ENGINES=(reddit "https://www.reddit.com/search/?q="
                        yt "https://www.youtube.com/results?search_query="

                       )


source $ZSH/oh-my-zsh.sh

#ALIASES
alias dev="cd ~/Dev/"
alias docs="cd ~/Documents/"
alias down="cd ~/Downloads/"
alias pics="cd ~/Pictures/"
alias cs="cd ~/Dropbox/College/"
alias hdd="cd ~/HDD/"
alias mail="cd ~/Mail/"
alias dotfiles="cd ~/Dev/dotfiles-ideapad"
alias org="cd ~/Dropbox/org"

alias l='/opt/coreutils/bin/ls'
alias cat="bat"
alias vim="nvim"
#alias emacs='emacsclient -nw'
alias freenode='irssi -n Ivche -c chat.freenode.net'
alias zshconf='nvim ~/.zshrc'
alias i3conf='nvim ~/.config/i3/config'
alias diskspace='ncdu'
alias genpass='pass generate -c'
alias serv='ssh root@candywatch.net'
alias config='/usr/bin/git --git-dir=/home/ivche/.cfg/ --work-tree=/home/ivche'

alias tl='todoist sync && todoist list'
alias ta='todoist sync && todoist add'
alias doomsync='~/.emacs.d/bin/doom sync && systemctl restart emacs --user'

alias vpn='sudo wg-quick up wg0' 
alias killvpn='sudo wg-quick down wg0'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
 
# Random Config
xset r rate 300 50
#neofetch --color_blocks off #| lolcat
#curl https://wttr.in/Skopje\?0
unsetopt BEEP

export ANDROID_HOME=$HOME/Android/Sdk
#PATH
export PATH=$PATH:~/.local/bin/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
