# Sourcing relevant scripts
source $HOME/.scripts/env/vars.sh
source $HOME/.scripts/env/aliases.sh
source $HOME/.scripts/env/funcs.sh

export DISABLE_AUTO_TITLE='true'
export ZSH="/home/ivche/.oh-my-zsh"

ZSH_THEME=clean
plugins=(git archlinux copydir vi-mode colorize copyfile extract z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
 
# Sane defaults
xset r rate 300 50
unsetopt BEEP
neofetch

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
