# Sourcing relevant scripts
source $HOME/.scripts/env/vars.sh
source $HOME/.scripts/env/aliases.sh
source $HOME/.scripts/env/funcs.sh

export DISABLE_AUTO_TITLE='true'
export ZSH="/home/ivche/.oh-my-zsh"

ZSH_THEME=fino-time
plugins=(git archlinux colorize copyfile extract z zsh-autosuggestions fast-syntax-highlighting zsh-vi-mode)


fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Sane defaults
unsetopt BEEP
afetch
