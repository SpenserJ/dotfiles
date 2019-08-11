#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "Don't run this as root"
  exit
fi

sudo pacman -Syu --noconfirm \
  base-devel neovim tmux zsh wireless_tools jsoncpp keepassxc chromium \
  i3-gaps dunst rofi xautolock playerctl xdotool scrot mpv \
  virt-manager libvirt qemu virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat

yaourt -Syu --noconfirm \
  slack-desktop insync autorandr-git maim gpmdp yay i3lock-color-git\
  polybar nerd-fonts-noto-sans-mono nerd-fonts-noto-sans-regular-complete \
  xscreensaver-aerial-videos-1080 xwinwrap-git \
  compton-tryone-git

# Set ZSH as the primary shell
chsh -s `which zsh`

# Install Homeshick
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

UPDATED_DOTFILES=false
# Clone dotfiles
$HOME/.homesick/repos/homeshick/bin/homeshick clone SpenserJ/dotfiles -b -q
# If dotfiles are already cloned, update them
if [[ $? -ne 0 ]]; then
  echo "Pulling dotfiles"
  LAST_COMMIT=$(GIT_DIR=$HOME/.homesick/repos/dotfiles/.git git rev-parse --short HEAD)
  $HOME/.homesick/repos/homeshick/bin/homeshick pull dotfiles -b -q
  NEW_COMMIT=$(GIT_DIR=$HOME/.homesick/repos/dotfiles/.git git rev-parse --short HEAD)
  if [[ "$LAST_COMMIT" != "$NEW_COMMIT" ]]; then
    UPDATED_DOTFILES=true
  fi
else
  UPDATED_DOTFILES=true
  systemctl --user enable ssh-agent
fi

if [[ "$UPDATED_DOTFILES" == true ]]; then
  echo "Symlinking new dotfiles"
  $HOME/.homesick/repos/homeshick/bin/homeshick symlink dotfiles -f -b
fi
