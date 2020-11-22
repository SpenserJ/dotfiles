# uncomment this and the last line for zprof info
# zmodload zsh/zprof

# All of our zsh config files
typeset -U config_files
config_files=($HOME/.config/zsh/**/*.zsh)
# `${(M)config_files:#*/plugins.zsh}` will return files that match the expression
# `${config_files:#*/plugins.zsh}` will exclude files that match the expression

# Load the path files
for file in ${(M)config_files:#*/path.zsh}; do
  source "$file"
done

# Load the antibody plugins
for file in ${(M)config_files:#*/plugins.zsh}; do
  source "$file"
done

# Load everything except the plugins, path, and completion files
for file in ${config_files:#*/(plugins|path|completion).zsh}; do
  source "$file"
done

# Load the completion config
for file in ${(M)config_files:#*/completion.zsh}; do
  source "$file"
done

# Clean up any variables that we have set
unset config_files

# zprof
