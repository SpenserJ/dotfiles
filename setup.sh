#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "Don't run this as root"
  exit
fi

OS=$(lsb_release -i | awk '{print $3}')
if [ "$OS" == "LinuxMint" ] || [ "$OS" == "Ubuntu" ]; then
  echo "Detected OS as Ubuntu or Mint"

  # Install NeoVim
  sudo add-apt-repository --yes --update ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y neovim python-dev python-pip python3-dev python3-pip
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

  # Install standard dependencies
  sudo apt-get install tmux zsh dunst polybar feh
elif [ "$OS" == "ManjaroLinux" ]; then
  echo "Detected OS as Manjaro Linux"

  sudo pacman -Syu --noconfirm base-devel neovim tmux zsh dunst libmpdclient wireless_tools jsoncpp i3-gaps keepassxc chromium rofi virt-manager libvirt qemu virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat xautolock playerctl

  yaourt -Syu --noconfirm polybar ttf-font-awesome-4 slack-desktop insync python-pywal autorandr-git maim gpmdp
else
  echo "Could not detect OS"
  exit
fi

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
