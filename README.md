# Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

- **Shell**: Zsh with Oh My Zsh and Powerlevel10k theme
- **Editor**: Neovim with LazyVim configuration
- **Terminal**: Ghostty, Kitty configurations
- **Multiplexer**: tmux
- **Git**: Custom gitconfig with delta for diffs
- **Tools**: bat, lazygit, starship, and more

## Prerequisites

- [Homebrew](https://brew.sh/) (macOS) or your system package manager
- [chezmoi](https://www.chezmoi.io/install/)
- Git

## Installation

### 1. Install chezmoi and apply dotfiles

```bash
# Install chezmoi and initialize with this repo in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply douglascamata

# Or if you already have chezmoi installed
chezmoi init --apply douglascamata
```

### 2. Install dependencies (macOS)

```bash
# Install all packages from Brewfile
brew bundle --file=~/.local/share/chezmoi/Brewfile
```

### 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Usage

### Applying Changes

After making changes to your dotfiles, apply them with:

```bash
chezmoi apply -v
```

### Editing Files

Edit a managed file directly:

```bash
chezmoi edit ~/.zshrc
```

Or edit in the source directory and then apply:

```bash
cd ~/.local/share/chezmoi
# Make your changes
chezmoi apply -v
```

### Checking What Would Change

Preview changes before applying:

```bash
chezmoi diff
```

### Adding New Files

Add a new file to be managed by chezmoi:

```bash
chezmoi add ~/.config/some-app/config
```

### Pulling Latest Changes

Update dotfiles from the remote repository:

```bash
chezmoi update
```

## Templated Files

Files ending in `.tmpl` are templates that chezmoi processes. This allows for
OS-specific or machine-specific configurations. For example, `dot_zshrc.tmpl`
has conditional blocks for Linux vs macOS.
