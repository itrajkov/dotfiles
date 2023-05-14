if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx "~/.xinitrc"
fi

xset r rate 300 50
export EDITOR="emacsclient --nw"
unsetopt BEEP
