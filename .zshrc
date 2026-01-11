fastfetch

export EDITOR=nano

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

autoload -Uz compinit
compinit

# Srouce aliases
if [ -f "$HOME/.config/zsh/aliases.zsh" ]; then
    source "$HOME/.config/zsh/aliases.zsh"
fi

# Source ssh-agent
if [ -f "$HOME/.config/zsh/ssh-agent.zsh" ]; then
    source "$HOME/.config/zsh/ssh-agent.zsh"
fi

# Source FZF (CTRL R for FZF)
source <(fzf --zsh)

# Oh-My-Posh
#eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/posh-theme.json")"

#export PATH="$PATH:/usr/local/android-studio/bin"
#export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"
