function tmux-launch {
  if [ -z "$2" ]; then
    NAME=$1;
  else
    NAME=$2;
  fi

  # Create the session if it doesn't already exist.
  tmux has-session -t $1 2>/dev/null
  if [ "$?" -eq 1 ]; then
    echo "Creating session $NAME"
    SAVED_TMUX="$TMUX"
    TMUX=
    tmux new-session -d -s "$NAME" "tmux source-file ~/.tmux/sessions/$1"
    TMUX="$SAVED_TMUX"
  fi

  # Switch to or attach the session
  if [ -z "$TMUX" ]; then
    tmux attach -t "$NAME"
  else
    tmux switch -t "$NAME"
  fi
}

tmux-work () {
  tmux-launch 'work' 'Work'
}

tmux-misc () {
  tmux-launch 'misc' 'Misc'
}

tmux-ansible () {
  tmux-launch 'ansible' 'Ansible'
}
