#! /bin/bash

function join { local IFS="$1"; shift; echo "$*"; }
echo "Setting up the system..."

# Set date time
ln -sf /usr/share/zoneinfo/Europe/Skopje /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set hostname
echo "ideapad" >> /etc/hostname
echo "127.0.1.1 ideapad.localdomain  ideapad" >> /etc/hosts

# Generate initramfs
mkinitcpio -P

# Set root password
passwd

# Install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg

# Install the rest of the packages
source packages
DEV_PACKAGES=$(join ' ' ${DEV_PACKAGES[@]})
SERVICES=$(join ' ' ${SERVICES[@]})
DAEMONS=$(join ' ' ${DAEMONS[@]})
MISC=$(join ' ' ${MISC[@]})

pacman -S $DEV_PACKAGES $SERVICES $DAEMONS $MISC

# Install yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si)
if [ $? -eq 0 ]; then
    yay -S auto-cpufreq todoist fast spt dropbox stretchly spotify pomotroid gnome-calculator i3lock-color polybar lyrics-in-terminal brave-bin nvm picom-ibhagwan-git
else
    echo "Failed to install yay!"
fi

# Create new user
useradd -m -G wheel,power,input,storage,uucp,network -s /usr/bin/zsh ivche
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
echo "Set password for new user ivche"
passwd ivche

# Create home filesystem for my user
mkdir -p /home/ivche/Dev
mkdir -p /home/ivche/Documents
mkdir -p /home/ivche/Downloads
mkdir -p /home/ivche/Pictures/screenshots
mkdir -p /home/ivche/Pictures/wallpapers
mkdir -p /home/ivche/Books
mkdir -p /home/ivche/Mail
mkdir -p /home/ivche/Games

# Enable services
systemctl enable NetworkManager.service
systemctl enable cups.service
systemctl enable systemd-resolved.service
systemctl enable wpa_supplicant.service

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs /home/ivche/.emacs.d
/home/ivche/.emacs.d/bin/doom install

# Deploy dotfiles
curl -Lks https://raw.githubusercontent.com/Ivche1337/dotfiles/master/.scripts/deployenv.sh | /bin/bash

echo "System setup done. You can exit chroot."
