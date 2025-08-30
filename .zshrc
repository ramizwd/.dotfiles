# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Srouce aliases
if [ -f "$HOME/.config/zsh/aliases.zsh" ]; then
    source "$HOME/.config/zsh/aliases.zsh"
fi

# Source ssh-agent
if [ -f "$HOME/.config/zsh/ssh-agent.zsh" ]; then
    source "$HOME/.config/zsh/ssh-agent.zsh"
fi

# Oh-My-Posh
eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/posh-theme.json")"

export PATH="$PATH:/usr/local/android-studio/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

fastfetch
