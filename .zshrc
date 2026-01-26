typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/Android/Sdk/platform-tools"
    $path
)
export PATH
export EDITOR=nano

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Autocompletion
autoload -Uz compinit
compinit

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Source FZF (CTRL R for FZF)
source <(fzf --zsh)

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

# Srouce aliases
if [ -f "$HOME/.config/zsh/aliases.zsh" ]; then
    source "$HOME/.config/zsh/aliases.zsh"
fi

# Source ssh-agent
if [ -f "$HOME/.config/zsh/ssh-agent.zsh" ]; then
    source "$HOME/.config/zsh/ssh-agent.zsh"
fi

fastfetch
