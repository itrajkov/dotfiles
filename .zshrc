# Sourcing relevant scripts
source $HOME/.scripts/env/vars.sh
source $HOME/.scripts/env/aliases.sh
source $HOME/.scripts/env/funcs.sh

export DISABLE_AUTO_TITLE='true'
export ZSH="/home/ivche/.oh-my-zsh"

ZSH_THEME=af-magic
plugins=(git archlinux vi-mode colorize copyfile extract z)

source $ZSH/oh-my-zsh.sh

bindkey -s ^f ".scripts/utils/tmux-sessionizer\n"
bindkey -s ^p ".scripts/utils/tmux-projector\n"
# Vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
 
# Sane defaults
xset r rate 300 50
unsetopt BEEP
afetch
 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
