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

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
 
# Sane defaults
unsetopt BEEP
afetch
