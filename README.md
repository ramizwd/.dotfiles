# dots

## Installation 
1.  **Clone the repository:**

```bash
git clone --bare <repo link> $HOME/.dotfiles
```

2.  **Set up the alias:**

Add the following line to your shell configuration file and source it or restart your shell.

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

```bash
source ~/.zshrc
```

3.  **Configure the repository:**

Prevent Git from showing untracked files in your home directory.

```bash
dotfiles config --local status.showUntrackedFiles no
```

4.  **Checkout your dotfiles:**

Use the alias to checkout the files from the repository into your home directory.

```bash
dotfiles checkout main
```
> [!CAUTION]
This will overwrite existing files with the same names.

