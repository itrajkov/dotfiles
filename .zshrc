# Sourcing relevant scripts
source $HOME/.scripts/env/vars.sh
source $HOME/.scripts/env/aliases.sh
source $HOME/.scripts/env/funcs.sh

export DISABLE_AUTO_TITLE='true'
export ZSH="/home/ivche/.oh-my-zsh"

ZSH_THEME=clean
plugins=(git archlinux copydir vi-mode web-search colorize copyfile extract z zsh-syntax-highlighting)

# web-search plugin config
ZSH_WEB_SEARCH_ENGINES=(reddit "https://www.reddit.com/search/?q="
                        yt "https://www.youtube.com/results?search_query=")


source $ZSH/oh-my-zsh.sh

# Vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
 
# Sane defaults
xset r rate 300 50
curl https://wttr.in/Skopje\?0
unsetopt BEEP
