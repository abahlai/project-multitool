# Kubectl completion and aliases
source <(kubectl completion bash)
alias k=kubectl
alias ls=exa
alias vi=vim
complete -F __start_kubectl k
export EDITOR="vim"

# Starship init
eval "$(starship init bash)"

# direnv hook init
eval "$(direnv hook bash)"

# Enable fuzzy search
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

# Enable keychain
/usr/bin/keychain $HOME/.ssh/wu_ssh
source $HOME/.keychain/$HOSTNAME-sh

# Terraform aliases
[ -f ~/.terraform_aliases ] && source ~/.terraform_aliases
function terraform() { echo "+ terraform $@"; command terraform $@; }

# Awesome oneliners
b64d () {
  echo "$1" | base64 -d ; echo
}

b64e () {
  echo -n "$1" | base64
}

alias cls='printf "\033c"'