POWERLINE_VERSION_CONTROL_BRANCH=""
POWERLINE_LOCKED=""
POWERLINE_ARROW_RIGHT_SOLID=""
POWERLINE_ARROW_RIGHT_LIGHT=""
POWERLINE_ARROW_LEFT_SOLID=""
POWERLINE_ARROW_LEFT_LIGHT=""

CURRENT_BG='NONE'
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$POWERLINE_ARROW_RIGHT_SOLID%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -Pn $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$POWERLINE_ARROW_RIGHT_SOLID"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}
