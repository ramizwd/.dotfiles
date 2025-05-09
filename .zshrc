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

# Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/posh-theme.json)"

# Aliases
alias ll="ls -lhA"
alias c="code"
alias vim="nvim"
alias k="kate"
alias py="python"
alias g="git"
alias gs="git status"
alias ga="git add ."
alias gap="git add -p"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ff="fastfetch"

fastfetch
