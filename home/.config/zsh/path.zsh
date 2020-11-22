# Source NVM if it is installed
if [ -e /usr/share/nvm/init-nvm.sh ]; then
  source /usr/share/nvm/init-nvm.sh
fi

# Set up Homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
