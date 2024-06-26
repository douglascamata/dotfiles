# douglascamata's dotfiles

These are my dotfiles and they are supposed to be managed with [stow](https://www.gnu.org/software/stow/).

## How to install on a new system?

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Turn off Homebrew analytics
brew analytics off
# Install git, tmux, neovim, kitty, and stow
brew install git tmux stow kitty neovim
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Change default shell to zsh
chsh -s $(which zsh)
````

```sh
# Restore the stowed dotfiles
for dir in */; do
  stow "$dir"
done
```

## How to add dotfiles?

1. Backup the configuration file to a safe place.
1. Replicate the path structure to the configuration (relative to `$HOME`)
   inside a **package** folder in the repo.
1. `touch` the files that are about to be added.
1. Run `stow --adopt <package_name>` to adopt the files in the system into
   the touched files in the package.
1. Check that the symlink exists and is correct.
1. Check that the file contents are correct.
1. Commit and push.
