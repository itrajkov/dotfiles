xset r rate 300 50
export EDITOR="emacsclient --nw"
export BEMENU_OPTS='--fb "#1e1e2e" --ff "#cdd6f4" --nb "#1e1e2e" --nf "#cdd6f4" --tb "#1e1e2e" --hb "#1e1e2e" --tf "#f38ba8" --hf "#f9e2af" --af "#cdd6f4" --ab "#1e1e2e" --fn "noto:Nerd Font Mono 14" 10 -l 3 --hp 5 -H 10'
export ELECTRON_OZONE_PLATFORM_HINT=auto

unsetopt BEEP

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep hyprland || Hyprland
fi
