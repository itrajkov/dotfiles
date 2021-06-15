if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx "~/.xinitrc"
fi

export EDITOR="emacsclient --nw"
eval "$(gh completion -s zsh)"
