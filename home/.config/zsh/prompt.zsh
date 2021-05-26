# Any command taking longer than 1s should have its time printed
PURE_CMD_MAX_EXEC_TIME=1

# Set up the Kubernetes context in the prompt. It is automatically enabled and
# disabled by ~/.config/zsh/hooks/kubernetesPrompt.zsh
KUBE_PS1_NS_ENABLE=false
KUBE_PS1_SEPARATOR=""
PROMPT='$(kube_ps1)'$PROMPT
znap prompt
