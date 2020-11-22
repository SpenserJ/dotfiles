_custom_enable_kubernetes_prompt () {
  PWD="$(pwd)"
  if [[ $PWD = /home/spenser/src/energyphile/* ]]; then
    KUBE_PS1_ENABLED=on
  else
    KUBE_PS1_ENABLED=off
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _custom_enable_kubernetes_prompt
_custom_enable_kubernetes_prompt
