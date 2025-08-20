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
alias gb="git branch"
alias gs="git status"
alias gch="git checkout"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit -m"
alias gpsh="git push"
alias gp="git pull"
alias gl="git log --oneline --graph --decorate"
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias wttr="curl wttr.in"
alias ff="fastfetch"

export PATH="$PATH:/usr/local/android-studio/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

fastfetch
