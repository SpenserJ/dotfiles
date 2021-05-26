# Source NVM if it is installed
if [ -e /usr/share/nvm/init-nvm.sh ]; then
  source /usr/share/nvm/init-nvm.sh
fi

# Add RVM to the path if it is installed
if [ -e "$HOME/.rvm/bin" ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi

# Set up Homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh
