# Sourcing relevant scripts
source $HOME/.scripts/env/vars.sh
source $HOME/.scripts/env/aliases.sh
source $HOME/.scripts/env/funcs.sh

export DISABLE_AUTO_TITLE='true'
export ZSH="/home/ivche/.oh-my-zsh"

ZSH_THEME=fino-time
plugins=(git archlinux vi-mode colorize copyfile extract z zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
 
# Sane defaults
unsetopt BEEP
afetch
