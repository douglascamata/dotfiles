# douglascamata's dotfiles

These are my dotfiles and they are supposed to be managed with [stow](https://www.gnu.org/software/stow/).

## How to install on a new system?

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Turn off Homebrew analytics
brew analytics off
# Install brew bundle
brew bundle install --file=./Brewfile
# Set up zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Change default shell to zsh
chsh -s $(which zsh)
````

## How to restore ALL the dotfiles?

Use the script `./stow.sh`. It stows all the folders (packages) contained in
this repo.

## How to add dotfiles?

Use the script `./adopt.sh <PACKAGE_NAME> <TARGET>`. It will use `stow --adopt`
to adopt the target. If the target is a file, it will be adopted and stowed.

In case of a adopting folder, the following happens:

1. The folder structure is created in the repo in a non-destructive way.
2. If the destination folder is not empty, the script will abort.
3. All files in the target will be copied into the repo.
4. The package will be stowed at the target.

You only need to check the contents of the symlink, commit, and push!
