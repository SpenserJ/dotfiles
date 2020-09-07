export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/chromium

# Fix SSH agent socket in Manjaro
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

export PATH="$PATH:$HOME/.config/scripts"
